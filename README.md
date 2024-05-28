# ScoreRandomizer
This repository contains an Elixir/Phoenix app that generates great amount of randomized scores

# Installation 
Follow the instructions to install Elixir 1.16-opt-26 [Elixir Lang Org Page](https://elixir-lang.org/install.html) 
If you have a different version of Elixir installed, I recommend using asdf for version management. 
For more information visit [asdf homepage](https://asdf-vm.com/guide/getting-started.html)

# Run the app
To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * To connect with the API, is necessary to make HTTP request to your local endpoint http://localhost:4000/api/v1/ 

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

# Description
The idea behind this project is to create a program that can track randomly generated scores in a large dataset table, showcasing the full extent of Phoenix capabilities.

## Implementation
### Create Scores-**Endpoint to Create a New Score**  -Fields:
    -**Value**: Integer [1..100]
    -**Id**: UUID
    -**Timestamps**  -If the value is not provided in the payload or is 0, assign a random value.
  -Persist these records in a database.
### Show Scores-**Endpoint `get_score`**
  - Returns 5 random entries where the values are greater than 50.
  - The returned results should include:
    - **id**
    - **value**
    - **inserted_at**    -**updated_at**
### Score Storage (Enhancements)
- **Create Bulk Records**
  - Functionality to create 1,000,000 records in the database.
- **Delete and Recreate Records**
  - Functionality to delete and recreate all records in the table.
  - This function should be callable using `mix`.
### Real Randomness
- **Update Records Periodically**
  - Update all 1 million records every 10 seconds.
  - Ensure all previous functionalities continue to work as expected.
  - Gradually reduce the update interval to 1 second without causing the app to crash.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

