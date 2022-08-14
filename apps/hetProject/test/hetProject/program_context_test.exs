defmodule HetProject.ProgramContextTest do
  use HetProject.DataCase

  alias HetProject.ProgramContext

  describe "programs" do
    alias HetProject.ProgramContext.Program

    import HetProject.ProgramContextFixtures

    @invalid_attrs %{author: nil, difficulty: nil, duration: nil, name: nil, type: nil}

    test "list_programs/0 returns all programs" do
      program = program_fixture()
      assert ProgramContext.list_programs() == [program]
    end

    test "get_program!/1 returns the program with given id" do
      program = program_fixture()
      assert ProgramContext.get_program!(program.id) == program
    end

    test "create_program/1 with valid data creates a program" do
      valid_attrs = %{author: "some author", difficulty: "some difficulty", duration: 42, name: "some name", type: "some type"}

      assert {:ok, %Program{} = program} = ProgramContext.create_program(valid_attrs)
      assert program.author == "some author"
      assert program.difficulty == "some difficulty"
      assert program.duration == 42
      assert program.name == "some name"
      assert program.type == "some type"
    end

    test "create_program/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProgramContext.create_program(@invalid_attrs)
    end

    test "update_program/2 with valid data updates the program" do
      program = program_fixture()
      update_attrs = %{author: "some updated author", difficulty: "some updated difficulty", duration: 43, name: "some updated name", type: "some updated type"}

      assert {:ok, %Program{} = program} = ProgramContext.update_program(program, update_attrs)
      assert program.author == "some updated author"
      assert program.difficulty == "some updated difficulty"
      assert program.duration == 43
      assert program.name == "some updated name"
      assert program.type == "some updated type"
    end

    test "update_program/2 with invalid data returns error changeset" do
      program = program_fixture()
      assert {:error, %Ecto.Changeset{}} = ProgramContext.update_program(program, @invalid_attrs)
      assert program == ProgramContext.get_program!(program.id)
    end

    test "delete_program/1 deletes the program" do
      program = program_fixture()
      assert {:ok, %Program{}} = ProgramContext.delete_program(program)
      assert_raise Ecto.NoResultsError, fn -> ProgramContext.get_program!(program.id) end
    end

    test "change_program/1 returns a program changeset" do
      program = program_fixture()
      assert %Ecto.Changeset{} = ProgramContext.change_program(program)
    end
  end
end
