# frozen_string_literal: true

module CacheConcern
  extend ActiveSupport::Concern

  def time_to_cache
    (ENV['TIME_TO_CACHE'] || 1440).to_i.minutes
  end

  def invalidate_cache?
    params['invalidate_cache'] == 'true'
  end

  def retrieve_cache(key)
    if invalidate_cache?
      yield
    else
      Rails.cache.fetch(
        computed_key(key),
        expires_in: time_to_cache,
        race_condition_ttl: 10.seconds
      ) do
        yield
      end
    end
  end

  def clear_cache(key)
    Rails.cache.delete(computed_key(key))
  end

  def computed_key(key)
    key
  end
end
