module BluePay
  module ApiRequest
    # Turns a hash into a nvp style string
    def uri_query(param_hash)
      array = []
      param_hash.each_pair { |key, val| array << (CGI.escape(key) + '=' + CGI.escape(val)) }
      array.join('&')
    end

    # Generates TPS hash based on given hash type
    def create_tps_hash(data, hash_type)
      return 'SECRET KEY  NOT PROVIDED' unless defined? @SECRET_KEY

      case hash_type
      when 'HMAC_SHA256'
        OpenSSL::HMAC.hexdigest('sha256', @SECRET_KEY, data)
      when 'SHA512'
        Digest::SHA512.hexdigest(@SECRET_KEY + data)
      when 'SHA256'
        Digest::SHA256.hexdigest(@SECRET_KEY + data)
      when 'MD5'
        Digest::MD5.hexdigest(@SECRET_KEY + data)
      else
        OpenSSL::HMAC.hexdigest('sha512', @SECRET_KEY, data)
      end
    end

    # Sets TAMPER_PROOF_SEAL in @PARAM_HASH
    def calc_tps
      @PARAM_HASH['TAMPER_PROOF_SEAL'] = create_tps_hash(
        @ACCOUNT_ID +
        (@PARAM_HASH['TRANSACTION_TYPE'] || '') +
        @PARAM_HASH['AMOUNT'] +
        (@PARAM_HASH['REBILLING'] || '') +
        (@PARAM_HASH['REB_FIRST_DATE'] || '') +
        (@PARAM_HASH['REB_EXPR'] || '') +
        (@PARAM_HASH['REB_CYCLES'] || '') +
        (@PARAM_HASH['REB_AMOUNT'] || '') +
        (@PARAM_HASH['RRNO'] || '') +
        @PARAM_HASH['MODE'],
        @PARAM_HASH['TPS_HASH_TYPE']
      )
    end

    # Sets TAMPER_PROOF_SEAL in @PARAM_HASH for rebadmin API
    def calc_rebill_tps
      @PARAM_HASH['TAMPER_PROOF_SEAL'] = create_tps_hash(
        @ACCOUNT_ID +
        @PARAM_HASH['TRANS_TYPE'] +
        @PARAM_HASH['REBILL_ID'],
        @PARAM_HASH['TPS_HASH_TYPE']
      )
    end

    # Sets TAMPER_PROOF_SEAL in @PARAM_HASH for bpdailyreport2 API
    def calc_report_tps
      @PARAM_HASH['TAMPER_PROOF_SEAL'] = create_tps_hash(
        "#{@ACCOUNT_ID}#{@PARAM_HASH['REPORT_START_DATE']}#{@PARAM_HASH['REPORT_END_DATE']}",
        @PARAM_HASH['TPS_HASH_TYPE']
      )
    end

    # sends HTTPS POST to BluePay gateway for processing
    def process
      ua = Net::HTTP.new(BluePay::Client::SERVER, 443)
      ua.use_ssl = true

      # Set default hash function to HMAC SHA-512
      @PARAM_HASH['TPS_HASH_TYPE'] = 'HMAC_SHA512'

      # Checks presence of CA certificate
      if File.directory?(BluePay::Client::RootCA)
        ua.ca_path = BluePay::Client::RootCA
        ua.verify_mode = OpenSSL::SSL::VERIFY_PEER
        ua.verify_depth = 3
      else
        puts 'Invalid CA certificates directory. Exiting...'
        exit
      end

      # Sets CUSTOMER_IP parameter
      begin
        @PARAM_HASH['CUSTOMER_IP'] = request.env['REMOTE_ADDR']
      rescue Exception
      end

      # Response version to be returned
      @PARAM_HASH['RESPONSEVERSION'] = '5'

      # Generate the query string and headers.  Chooses which API to make request to.
      case @api
      when 'bpdailyreport2'
        calc_report_tps
        path = '/interfaces/bpdailyreport2'
        query = "ACCOUNT_ID=#{@ACCOUNT_ID}&" + uri_query(@PARAM_HASH)
      when 'stq'
        calc_report_tps
        path = '/interfaces/stq'
        query = "ACCOUNT_ID=#{@ACCOUNT_ID}&" + uri_query(@PARAM_HASH)
      when 'bp10emu'
        calc_tps
        path = '/interfaces/bp10emu'
        query = "MERCHANT=#{@ACCOUNT_ID}&" + uri_query(@PARAM_HASH)
        # puts "****"; puts uri_query(@PARAM_HASH).inspect
      when 'bp20rebadmin'
        calc_rebill_tps
        path = '/interfaces/bp20rebadmin'
        query = "ACCOUNT_ID=#{@ACCOUNT_ID}&" + uri_query(@PARAM_HASH)
      end
      queryheaders = {
        'User-Agent' => 'BluePay Ruby Library/' + BluePay::Client::RELEASE_VERSION,
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      # Post parameters to BluePay gateway
      # Resuce SSL error and retry with ca_file absolute path.
      begin
        headers, body = ua.post(path, query, queryheaders)
      rescue OpenSSL::SSL::SSLError
        ua.ca_file = __dir__ + '/' + BluePay::Client::RootCAFile
        headers, body = ua.post(path, query, queryheaders)
      end

      # Split the response into the response hash.
      @RESPONSE_HASH = {}
      response = if path == '/interfaces/bp10emu'
                   headers['Location'].split('?')[1]
                 else
                   headers.body
                 end
      if path == '/interfaces/bpdailyreport2'
        response
      else
        response.split('&').each do |pair|
          (key, val) = pair.split('=')
          val = '' if val.nil?
          @RESPONSE_HASH[URI.unescape(key)] = URI.unescape(val)
        end
      end
    end
  end
end
