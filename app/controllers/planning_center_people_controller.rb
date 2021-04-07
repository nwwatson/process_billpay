class PlanningCenterPeopleController < ApplicationController
  before_action :set_planning_center_person, only: %i[ show edit update destroy ]

  # GET /planning_center_people or /planning_center_people.json
  def index
    @planning_center_people = PlanningCenterPerson.all
  end

  # GET /planning_center_people/1 or /planning_center_people/1.json
  def show
  end

  # GET /planning_center_people/new
  def new
    @planning_center_person = PlanningCenterPerson.new
  end

  # GET /planning_center_people/1/edit
  def edit
  end

  # POST /planning_center_people or /planning_center_people.json
  def create
    @planning_center_person = PlanningCenterPerson.new(planning_center_person_params)

    respond_to do |format|
      if @planning_center_person.save
        format.html { redirect_to @planning_center_person, notice: "Planning center person was successfully created." }
        format.json { render :show, status: :created, location: @planning_center_person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @planning_center_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planning_center_people/1 or /planning_center_people/1.json
  def update
    respond_to do |format|
      if @planning_center_person.update(planning_center_person_params)
        format.html { redirect_to @planning_center_person, notice: "Planning center person was successfully updated." }
        format.json { render :show, status: :ok, location: @planning_center_person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @planning_center_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planning_center_people/1 or /planning_center_people/1.json
  def destroy
    @planning_center_person.destroy
    respond_to do |format|
      format.html { redirect_to planning_center_people_url, notice: "Planning center person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planning_center_person
      @planning_center_person = PlanningCenterPerson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def planning_center_person_params
      params.require(:planning_center_person).permit(:planning_center_id, :first_name, :last_name, :string, :email)
    end
end
