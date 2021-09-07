class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_validations_error

    def index
        students = Student.all
        render json: students
    end

    def create
        student = Student.create(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :age, :major, :instructor_id)
    end

    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
    end

    def render_validations_error(invalid)
        render json: { errors: ["Validations error"] }, status: :unprocessable_entity
        # render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
