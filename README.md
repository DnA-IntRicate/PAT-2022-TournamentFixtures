# PAT-2022-TournamentFixtures
---

## Scenario
The principal of Big Beaver High-School along with the soccer team coaches have asked me to develop an application for them to use in which they can easily create, interact with and view tournament fixtures/ladders for their upcoming inter-class soccer tournaments this season across each grade. They would like for users of their application to be able to view the current tournament fixtures in real-time while disallowing them to modify these fixtures hence, they would also require a way of only allowing tournament administrators to modify and update these fixtures and also only allowing them to submit new teams onto the roster. They require a sustainable application to be developed which they would like to eventually use for all of their other tournaments in future seasons. Their typical tournament type is a Single-Elimination tournament ladder with a total of 20 teams being able to enter.

In a meeting with the principal of the school, she stated “I would like to have an application wherein I can view the fixtures and results of the teams currently playing, and it should be capable of being updated in real-time by those in-charge of the tournaments. I think that would be something really great and effective for us.” 

## Solution
To satisfy the school’s requirements of the application, it will feature a “main activity” form in which normal clients can view the tournament fixtures and match results. It will also feature an “admin login” panel that tournament administrators can use to login to the application with via username and password stored in the backend database. This will then lead to an admin form in which tournament administrators can update/modify the tournament fixtures and other related data stored in a local text file (JSON) including adding new players, teams and other administrators to the backend database.

| Accessible Functionality | Normal Clients | Tournament Admins | 
| -------------------------| ---------------| ------------------|
| Viewing tournament fixtures and match results | Yes | Yes |
| Updating and modifying fixtures and match results (modifying database) | No | Yes |
| Creating tournaments and submitting teams | No | Yes |

### Fixtures
The application will make use of a JSON file “Fixtures.json” to store the current state of the tournament’s fixtures. Each entry in the file will hold a TeamID from tblTeams in the database and associated with it it’s current stage on the ladder, its position within that stage and whether it has been eliminated or not.
```json 
{
    "type": "Fixture.TFixtures",
    "id": 1,
    "fields": {
        "Entries": [
            {
                "type": "Fixture.TFixture",
                "id": 2,
                "fields": {
                    "TeamID": 1,
                    "LadderStage": 0,
                    "StagePosition": 1,
                    "Eliminated": true
                }
            }
        ]
    }
}
```

Upon startup, the application will load this file’s contents into an array of fixture entries where each entry in this file is an entry in the array. This array will then be used to populate the visible tournament ladder on the main form.
For security reasons, admin passwords will not be stored as plain text in the backend database. Passwords will therefore be hashed (salted MD5) when being stored in the database (signup) and when being compared to the database (logins).
Example: `Password = 12345678; Hash = a2240212f6e8d7db337b46aab21433ad==`

### Line Counts
- 1525  /Source/AdminLoginForm.pas
- 55    /Source/Fixture.pas
- 71    /Source/JsonSerializer.pas
- 53    /Source/MainDatabase.pas
- 624   /Source/MainForm.pas
- 75    /Source/Team.pas
- *Total = 2403*
