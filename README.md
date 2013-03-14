SOMA
======

Starting the graphical server
------

To start the grahical server; run `make vinit`, set the port to 3333 and load the figures/parts with the GUI.

Starting the timing server
------

To the timing server, just run `make tinit`.


Running the solver (server)
------

Run the project by using `make solver liu_id=LIU` (replace LIU with your LiU id, e.g. danth407).
If you set the environment variable `liu_id` to your LiU id (with `export liu_id=danth407`) you can just run `make solver`.

Tests (server)
------

Run `make test liu_id=LIU` to test if the project is running correctly.
If you've made changes you'll want to make sure they're represented in `tests/` first.
