defmodule HetProjectWeb.ProgramController do
  use HetProjectWeb, :controller

  alias HetProject.ProgramContext
  alias HetProject.ProgramContext.Program
  alias HetProject.ExerciseContext
  #alias HetProject.ExerciseContext.Exercise

  #alias HetProject.Repo


  def index(conn, _params) do
    programs = ProgramContext.list_programs()
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", programs: programs, user: user)
  end

  def new(conn, _params) do

    changeset = ProgramContext.change_program(%Program{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"program" => program_params}) do
    #we nemen de user zijn email adres die standaard wordt ingevuld als author
    user = Guardian.Plug.current_resource(conn)

    program_params = Map.put(program_params, "author", user.email)


    case ProgramContext.create_program(program_params) do
      {:ok, program} ->
        conn
        |> put_flash(:info, "Program created successfully.")
        |> redirect(to: Routes.program_path(conn, :show, program))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    program = ProgramContext.get_program!(id)
    |> ProgramContext.load_users
    |> ProgramContext.load_exercises
    render(conn, "show.html", program: program)
  end

  def edit(conn, %{"id" => id}) do
    program = ProgramContext.get_program!(id)
    changeset = ProgramContext.change_program(program)
    render(conn, "edit.html", program: program, changeset: changeset)
  end

  def update(conn, %{"id" => id, "program" => program_params}) do
    program = ProgramContext.get_program!(id)

    case ProgramContext.update_program(program, program_params) do
      {:ok, program} ->
        conn
        |> put_flash(:info, "Program updated successfully.")
        |> redirect(to: Routes.program_path(conn, :show, program))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", program: program, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    program = ProgramContext.get_program!(id)
    {:ok, _program} = ProgramContext.delete_program(program)

    conn
    |> put_flash(:info, "Program deleted successfully.")
    |> redirect(to: Routes.program_path(conn, :index))
  end

  def addToUser(conn,%{"program_id" => program_id}) do

    user = Guardian.Plug.current_resource(conn)
    program = ProgramContext.get_program!(program_id)
    # case user do indien user niet is ingelogd -> error
    #   Nill ->
    #     conn
    #     |> redirect(to: Routes.program_path(conn, :index))
    # end

    #{program_id, ""} = Integer.parse(program_id)
    #user_id = Integer.to_string(user_id)

    case ProgramContext.addToUser(user,program) do

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", program: program, changeset: changeset)
      _ -> conn
          |> put_flash(:info, "Program added successfully.")
          |> redirect(to: Routes.program_path(conn, :show, program))
    end

  end

  def addExercises(conn,%{"program_id" => program_id}) do

      exercises = ExerciseContext.list_exercises()

      #program = ProgramContext.get_program!(program_id)
      render(conn, "exercises.html", program: program_id,exercises: exercises)
  end
# %{"program_id" => program_id},%{"exercise_id" => exercise_id}
  def addToProgram(conn, var) do


    #%{"exercise_id" => "1", "program_id" => "1"}
    exerciseId = var["exercise_id"]
    programId = var["program_id"]
    exercise = ExerciseContext.get_exercise!(exerciseId)
    program = ProgramContext.get_program!(programId)

    case ProgramContext.addExerciseToProgram(exercise,program) do
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", program: program, changeset: changeset)

       _ -> conn
          |> put_flash(:info, "Exercise added successfully.")
          |> redirect(to: Routes.program_path(conn, :index, program: program))
    end
  end

end
