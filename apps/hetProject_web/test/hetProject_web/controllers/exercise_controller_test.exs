defmodule HetProjectWeb.ExerciseControllerTest do
  use HetProjectWeb.ConnCase

  import HetProject.ExerciseContextFixtures

  @create_attrs %{difficulty: "some difficulty", explanation: "some explanation", muscles: "some muscles", name: "some name"}
  @update_attrs %{difficulty: "some updated difficulty", explanation: "some updated explanation", muscles: "some updated muscles", name: "some updated name"}
  @invalid_attrs %{difficulty: nil, explanation: nil, muscles: nil, name: nil}

  describe "index" do
    test "lists all exercises", %{conn: conn} do
      conn = get(conn, Routes.exercise_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Exercises"
    end
  end

  describe "new exercise" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.exercise_path(conn, :new))
      assert html_response(conn, 200) =~ "New Exercise"
    end
  end

  describe "create exercise" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.exercise_path(conn, :create), exercise: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.exercise_path(conn, :show, id)

      conn = get(conn, Routes.exercise_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Exercise"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.exercise_path(conn, :create), exercise: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Exercise"
    end
  end

  describe "edit exercise" do
    setup [:create_exercise]

    test "renders form for editing chosen exercise", %{conn: conn, exercise: exercise} do
      conn = get(conn, Routes.exercise_path(conn, :edit, exercise))
      assert html_response(conn, 200) =~ "Edit Exercise"
    end
  end

  describe "update exercise" do
    setup [:create_exercise]

    test "redirects when data is valid", %{conn: conn, exercise: exercise} do
      conn = put(conn, Routes.exercise_path(conn, :update, exercise), exercise: @update_attrs)
      assert redirected_to(conn) == Routes.exercise_path(conn, :show, exercise)

      conn = get(conn, Routes.exercise_path(conn, :show, exercise))
      assert html_response(conn, 200) =~ "some updated difficulty"
    end

    test "renders errors when data is invalid", %{conn: conn, exercise: exercise} do
      conn = put(conn, Routes.exercise_path(conn, :update, exercise), exercise: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Exercise"
    end
  end

  describe "delete exercise" do
    setup [:create_exercise]

    test "deletes chosen exercise", %{conn: conn, exercise: exercise} do
      conn = delete(conn, Routes.exercise_path(conn, :delete, exercise))
      assert redirected_to(conn) == Routes.exercise_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.exercise_path(conn, :show, exercise))
      end
    end
  end

  defp create_exercise(_) do
    exercise = exercise_fixture()
    %{exercise: exercise}
  end
end
