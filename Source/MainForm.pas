// Adam Foflonker 11C
unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  AdminLoginForm, Vcl.ExtCtrls, Jpeg, PngImage, Data.Win.ADODB, Data.DB, Team,
  MainDatabase, Fixture, JsonSerializer;

type
  TForm1 = class(TForm)
    btnAdminLogin: TButton;
    pnlFixtures: TPanel;
    imgLadder: TImage;
    lblQualifier_1: TLabel;
    lblQualifier_2: TLabel;
    lblQualifier_13: TLabel;
    lblQualifier_4: TLabel;
    lblQualifier_9: TLabel;
    lblQualifier_8: TLabel;
    lblQualifier_17: TLabel;
    lblQualifier_16: TLabel;
    lblQualifier_20: TLabel;
    lblQualifier_12: TLabel;
    lblQualifier_5: TLabel;
    lblQualifier_15: TLabel;
    lblQualifier_18: TLabel;
    lblQualifier_7: TLabel;
    lblQualifier_10: TLabel;
    lblQualifier_3: TLabel;
    lblQualifier_14: TLabel;
    lblQualifier_19: TLabel;
    lblQualifier_6: TLabel;
    lblQualifier_11: TLabel;
    btnRefresh: TButton;
    procedure btnAdminLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LoadDatabase();
    procedure LoadFixtures();
    procedure DisplayFixtures();
  end;

const
  TBL_TEAMS_FIELD_PK = 'TeamID';
  TBL_TEAMS_FIELD_NAME_TEAMCLASSNAME = 'TeamClassName';
  TBL_TEAMS_FIELD_NAME_GRADE = 'Grade';
  TBL_TEAMS_FIELD_NAME_TEAMLAYOUT = 'TeamLayout';
  TBL_TEAMS_FIELD_NAME_TEAMSUBMITTERADMINID = 'TeamSubmitterAdminID';

  FILE_PATH_FIXTURES_JSON = 'Fixtures.json';

var
  Form1: TForm1;
  g_Database: TMainDatabase;
  g_TeamList: TTeamList;
  g_Fixtures: TFixtures;

implementation

{$R *.dfm}

procedure TForm1.btnAdminLoginClick(Sender: TObject);
begin
  AdminLoginForm.Form2.Show();
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Form2.Database := g_Database;
  Form2.Fixtures := g_Fixtures;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  imgLadder.Picture.LoadFromFile('Assets/Images/BracketSeeded.png');
  imgLadder.Stretch := true;

  LoadDatabase();
  LoadFixtures();
  DisplayFixtures();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TForm1.LoadDatabase();
var
  tblTeams: TADOTable;
  newTeam: TTeam;
begin
  g_Database := TMainDatabase.Create();
  g_TeamList := TTeamList.Create();

  tblTeams := g_Database.tblTeams;
  tblTeams.Open();
  tblTeams.First();

  while not tblTeams.Eof do
  begin
    newTeam := TTeam.Create();
    newTeam.ID := tblTeams[TBL_TEAMS_FIELD_PK];
    newTeam.Name := tblTeams[TBL_TEAMS_FIELD_NAME_TEAMCLASSNAME];
    newTeam.Grade := tblTeams[TBL_TEAMS_FIELD_NAME_GRADE];
    newTeam.Layout := tblTeams[TBL_TEAMS_FIELD_NAME_TEAMCLASSNAME];
    newTeam.SubmitterAdminID :=
      tblTeams[TBL_TEAMS_FIELD_NAME_TEAMSUBMITTERADMINID];
    g_TeamList.Teams[newTeam.ID] := newTeam;
    tblTeams.Next();
  end;
end;

procedure TForm1.LoadFixtures();
var
  sJsonStr: string;
  jsSerializer: TJsonSerializer;
  istream: TStreamReader;
  iDlgAnswer: integer;
begin
  if FileExists(FILE_PATH_FIXTURES_JSON) then
  begin
    istream := TStreamReader.Create(FILE_PATH_FIXTURES_JSON, TEncoding.UTF8);
    sJsonStr := istream.ReadToEnd();
    istream.Close();

    try
      jsSerializer := TJsonSerializer.Create();
      g_Fixtures := TFixtures.Create();
      g_Fixtures := jsSerializer.DeserializeJson(sJsonStr) as TFixtures;
    except
      on e: Exception do
      begin
        g_Fixtures := TFixtures.Create();
        MessageDlg('Failed to read json data from corrupted file! - ' +
          e.Message, mtError, [mbOk], 0);
      end;
    end;
  end
  else
  begin
    iDlgAnswer := MessageDlg
      ('Local save file ''''Fixtures.json'''' was not found!' + #13#10 +
      'Would you like to create a new one?', mtWarning, mbYesNo, 0);

    if iDlgAnswer = mrYes then
      FileCreate(FILE_PATH_FIXTURES_JSON);
  end;
end;

procedure TForm1.DisplayFixtures();
var
  fx: TFixture;
begin
  for fx in g_Fixtures.Entries do
  begin
    case fx.LadderStage of
      LadderStage_Disqualified:
        begin
          case fx.StagePosition of
            1:
              begin
                lblQualifier_1.Font.Color := clRed;
                lblQualifier_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblQualifier_2.Font.Color := clRed;
                lblQualifier_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblQualifier_3.Font.Color := clRed;
                // red colour used for teams that lost
                lblQualifier_3.Font.Style := [fsStrikeOut];
                lblQualifier_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblQualifier_4.Font.Color := clRed;
                lblQualifier_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            5:
              begin
                lblQualifier_5.Font.Color := clRed;
                lblQualifier_5.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            6:
              begin
                lblQualifier_6.Font.Color := clRed;
                lblQualifier_6.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            7:
              begin
                lblQualifier_7.Font.Color := clRed;
                lblQualifier_7.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            8:
              begin
                lblQualifier_8.Font.Color := clRed;
                lblQualifier_8.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            9:
              begin
                lblQualifier_9.Font.Color := clRed;
                lblQualifier_9.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            10:
              begin
                lblQualifier_10.Font.Color := clRed;
                lblQualifier_10.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            11:
              begin
                lblQualifier_11.Font.Color := clRed;
                lblQualifier_11.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            12:
              begin
                lblQualifier_12.Font.Color := clRed;
                lblQualifier_12.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            13:
              begin
                lblQualifier_13.Font.Color := clRed;
                lblQualifier_13.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            14:
              begin
                lblQualifier_14.Font.Color := clRed;
                lblQualifier_14.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            15:
              begin
                lblQualifier_15.Font.Color := clRed;
                lblQualifier_15.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            16:
              begin
                lblQualifier_16.Font.Color := clRed;
                lblQualifier_16.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            17:
              begin
                lblQualifier_17.Font.Color := clRed;
                lblQualifier_17.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            18:
              begin
                lblQualifier_18.Font.Color := clRed;
                lblQualifier_18.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            19:
              begin
                lblQualifier_19.Font.Color := clRed;
                lblQualifier_19.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            20:
              begin
                lblQualifier_20.Font.Color := clRed;
                lblQualifier_20.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_Qualifier:
        begin
          case fx.StagePosition of
            1:
              begin
                lblQualifier_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblQualifier_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblQualifier_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblQualifier_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            5:
              begin
                lblQualifier_5.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            6:
              begin
                lblQualifier_6.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            7:
              begin
                lblQualifier_7.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            8:
              begin
                lblQualifier_8.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            9:
              begin
                lblQualifier_9.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            10:
              begin
                lblQualifier_10.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            11:
              begin
                lblQualifier_11.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            12:
              begin
                lblQualifier_12.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            13:
              begin
                lblQualifier_13.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            14:
              begin
                lblQualifier_14.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            15:
              begin
                lblQualifier_15.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            16:
              begin
                lblQualifier_16.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            17:
              begin
                lblQualifier_17.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            18:
              begin
                lblQualifier_18.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            19:
              begin
                lblQualifier_19.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            20:
              begin
                lblQualifier_20.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_QuarterFinal:
        begin

        end;
      LadderStage_SemiFinal:
        begin

        end;
      LadderStage_Final:
        begin

        end;
      LadderStage_Champion:
        begin

        end;
    end;
  end;
end;

end.
