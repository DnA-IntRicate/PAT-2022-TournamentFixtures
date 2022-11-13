Please note: When testing the program, do not run the program from the Delphi IDE. Please do so from the bin directory because the project has 
a post-build command which will delete the database in bin and re-copy the original database from Assets to that directory. 
i.e. If you add a new admin or update a password in the database, close the app and re-run it from the IDE. You may not see the changes reflected
in the database because it was overwritten by the project's post-build events.

GitHub repo: https://github.com/DnA-IntRicate/PAT-2022-TournamentFixtures