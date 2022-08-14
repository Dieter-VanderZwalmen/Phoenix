# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HetProject.Repo.insert!(%HetProject.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


#users
{:ok, _cs} =
  HetProject.UserContext.create_user(%{
    "password" => "Admin", "role" => "Admin", "name" => "Admin",
     "email" => "admin@admin.be"
  })
  {:ok, _cs} =
  HetProject.UserContext.create_user(%{
    "password" => "BA", "role" => "Business Analyst", "name" => "BA",
     "email" => "ba@ba.be"
  })

  {:ok, _cs} =
  HetProject.UserContext.create_user(%{
    "password" => "User", "role" => "User", "name" => "User",
     "email" => "user@user.be"
  })

#programs
  {:ok, _cs} =
  HetProject.ProgramContext.create_program(%{
    "author" => "User", "difficulty" => "Easy", "duration" => 5,
     "name" => "Beginner cardio program", "type"=> "cardio"
  })
  {:ok, _cs} =
  HetProject.ProgramContext.create_program(%{
    "author" => "Admin", "difficulty" => "Hard", "duration" => 12,
     "name" => "Advanced cardio program", "type"=> "cardio"
  })
#exercises
{:ok, _cs} =
HetProject.ExerciseContext.create_exercise(%{
    "difficulty" => "Hard", "explanation" => "Sprint up a hill. A full indepth explanation is available here: https://www.youtube.com/watch?v=AgUP_u604NA",
     "name" => "Hill sprints", "type"=> "Cardio", "muscles" =>"Mainly the Quadriceps but also the gluteus and the calfs"
  })

  {:ok, _cs} =
  HetProject.ExerciseContext.create_exercise(%{
    "difficulty" => "beginner", "explanation" => "Start in a lunged posistion and jump as high as possible with your front leg. Swing the knee of your other leg as high as possible",
     "name" => "Reverse Lunge to Knee-Up Jump", "type"=> "Plyometrics", "muscles" =>"Mainly the Quadriceps but also the gluteus and the calfs, The core acts as a stablizer"
  })
