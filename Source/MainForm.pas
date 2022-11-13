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
    lblQuarterFinal_1: TLabel;
    lblQuarterFinal_2: TLabel;
    lblQuarterFinal_4: TLabel;
    lblQuarterFinal_5: TLabel;
    lblQuarterFinal_3: TLabel;
    lblQuarterFinal_6: TLabel;
    lblQuarterFinal_7: TLabel;
    lblQuarterFinal_8: TLabel;
    lblSemiFinal_1: TLabel;
    lblSemiFinal_2: TLabel;
    lblSemiFinal_3: TLabel;
    lblSemiFinal_4: TLabel;
    lblFinal_1: TLabel;
    lblFinal_2: TLabel;
    lblChampion: TLabel;
    lblQualifier2_1: TLabel;
    lblQualifier2_2: TLabel;
    lblQualifier2_3: TLabel;
    lblQualifier2_4: TLabel;
    procedure btnAdminLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LoadDatabase();
    function LoadFixtures(): boolean;
    procedure DisplayFixtures();
    procedure btnRefreshClick(Sender: TObject);
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
  Form2.TeamList := g_TeamList;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  imgLadder.Picture.LoadFromFile('Assets/Images/BracketSeeded.png');
  imgLadder.Stretch := true;

  lblQualifier_1.Hide();
  lblQualifier_2.Hide();
  lblQualifier_3.Hide();
  lblQualifier_4.Hide();
  lblQualifier_5.Hide();
  lblQualifier_6.Hide();
  lblQualifier_7.Hide();
  lblQualifier_8.Hide();
  lblQualifier_9.Hide();
  lblQualifier_10.Hide();
  lblQualifier_11.Hide();
  lblQualifier_12.Hide();
  lblQualifier_13.Hide();
  lblQualifier_14.Hide();
  lblQualifier_15.Hide();
  lblQualifier_16.Hide();
  lblQualifier_17.Hide();
  lblQualifier_18.Hide();
  lblQualifier_19.Hide();
  lblQualifier_20.Hide();

  lblQualifier2_1.Hide();
  lblQualifier2_2.Hide();
  lblQualifier2_3.Hide();
  lblQualifier2_4.Hide();

  lblQuarterFinal_1.Hide();
  lblQuarterFinal_2.Hide();
  lblQuarterFinal_3.Hide();
  lblQuarterFinal_4.Hide();
  lblQuarterFinal_5.Hide();
  lblQuarterFinal_6.Hide();
  lblQuarterFinal_7.Hide();
  lblQuarterFinal_8.Hide();

  lblSemiFinal_1.Hide();
  lblSemiFinal_2.Hide();
  lblSemiFinal_3.Hide();
  lblSemiFinal_4.Hide();

  lblFinal_1.Hide();
  lblFinal_2.Hide();
  lblChampion.Hide();

  LoadDatabase();
  if LoadFixtures() then
    DisplayFixtures();
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

function TForm1.LoadFixtures(): boolean;
var
  sJsonStr: string;
  jsSerializer: TJsonSerializer;
  istream: TStreamReader;
  ostream: TStreamWriter;
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
      Result := true;
    except
      on e: Exception do
      begin
        g_Fixtures := TFixtures.Create();
        MessageDlg('Failed to read json data from corrupted file! - ' +
          e.Message, mtError, [mbOk], 0);

        Result := false;
      end;
    end;
  end
  else
  begin
    iDlgAnswer := MessageDlg('Local save file ''Fixtures.json'' was not found!'
      + #13#10 + 'Would you like to create a new one?', mtWarning, mbYesNo, 0);

    if iDlgAnswer = mrYes then
    begin
      FileCreate(FILE_PATH_FIXTURES_JSON);

      g_Fixtures := TFixtures.Create();
      jsSerializer := TJsonSerializer.Create();
      sJsonStr := jsSerializer.SerializeJson(g_Fixtures);

      ostream := TStreamWriter.Create(FILE_PATH_FIXTURES_JSON, false,
        TEncoding.UTF8, SizeOf(char) * sJsonStr.Length);
      ostream.Write(sJsonStr);
      ostream.Close();

      Result := true;
    end
    else
    begin
      Result := false;
    end;
  end;
end;

procedure TForm1.btnRefreshClick(Sender: TObject);
begin
  if LoadFixtures() then
    DisplayFixtures();
end;

procedure TForm1.DisplayFixtures();
var
  fx: TFixture;
begin
  for fx in g_Fixtures.Entries do
  begin
    case fx.LadderStage of
      LadderStage_Qualifier:
        begin
          case fx.StagePosition of
            1:
              begin
                lblQualifier_1.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_1.Font.Color := clRed;

                lblQualifier_1.Show();
                lblQualifier_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblQualifier_2.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_2.Font.Color := clRed;

                lblQualifier_2.Show();
                lblQualifier_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblQualifier_3.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_3.Font.Color := clRed;

                lblQualifier_3.Show();
                lblQualifier_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblQualifier_4.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_4.Font.Color := clRed;

                lblQualifier_4.Show();
                lblQualifier_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            5:
              begin
                lblQualifier_5.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_5.Font.Color := clRed;

                lblQualifier_5.Show();
                lblQualifier_5.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            6:
              begin
                lblQualifier_6.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_6.Font.Color := clRed;

                lblQualifier_6.Show();
                lblQualifier_6.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            7:
              begin
                lblQualifier_7.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_7.Font.Color := clRed;

                lblQualifier_7.Show();
                lblQualifier_7.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            8:
              begin
                lblQualifier_8.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_8.Font.Color := clRed;

                lblQualifier_8.Show();
                lblQualifier_8.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            9:
              begin
                lblQualifier_9.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_9.Font.Color := clRed;

                lblQualifier_9.Show();
                lblQualifier_9.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            10:
              begin
                lblQualifier_10.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_10.Font.Color := clRed;

                lblQualifier_10.Show();
                lblQualifier_10.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            11:
              begin
                lblQualifier_11.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_11.Font.Color := clRed;

                lblQualifier_11.Show();
                lblQualifier_11.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            12:
              begin
                lblQualifier_12.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_12.Font.Color := clRed;

                lblQualifier_12.Show();
                lblQualifier_12.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            13:
              begin
                lblQualifier_13.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_13.Font.Color := clRed;

                lblQualifier_13.Show();
                lblQualifier_13.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            14:
              begin
                lblQualifier_14.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_14.Font.Color := clRed;

                lblQualifier_14.Show();
                lblQualifier_14.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            15:
              begin
                lblQualifier_15.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_15.Font.Color := clRed;

                lblQualifier_15.Show();
                lblQualifier_15.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            16:
              begin
                lblQualifier_16.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_16.Font.Color := clRed;

                lblQualifier_16.Show();
                lblQualifier_16.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            17:
              begin
                lblQualifier_17.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_17.Font.Color := clRed;

                lblQualifier_17.Show();
                lblQualifier_17.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            18:
              begin
                lblQualifier_18.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_18.Font.Color := clRed;

                lblQualifier_18.Show();
                lblQualifier_18.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            19:
              begin
                lblQualifier_19.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_19.Font.Color := clRed;

                lblQualifier_19.Show();
                lblQualifier_19.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            20:
              begin
                lblQualifier_20.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier_20.Font.Color := clRed;

                lblQualifier_20.Show();
                lblQualifier_20.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_Qualifier2:
        begin
          case fx.StagePosition of
            1:
              begin
                lblQualifier2_1.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier2_1.Font.Color := clRed;

                lblQualifier2_1.Show();
                lblQualifier2_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblQualifier2_2.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier2_2.Font.Color := clRed;

                lblQualifier2_2.Show();
                lblQualifier2_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblQualifier2_3.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier2_3.Font.Color := clRed;

                lblQualifier2_3.Show();
                lblQualifier2_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblQualifier2_4.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQualifier2_4.Font.Color := clRed;

                lblQualifier2_4.Show();
                lblQualifier2_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_QuarterFinal:
        begin
          case fx.StagePosition of
            1:
              begin
                lblQuarterFinal_1.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_1.Font.Color := clRed;

                lblQuarterFinal_1.Show();
                lblQuarterFinal_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblQuarterFinal_2.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_2.Font.Color := clRed;

                lblQuarterFinal_2.Show();
                lblQuarterFinal_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblQuarterFinal_3.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_3.Font.Color := clRed;

                lblQuarterFinal_3.Show();
                lblQuarterFinal_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblQuarterFinal_4.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_4.Font.Color := clRed;

                lblQuarterFinal_4.Show();
                lblQuarterFinal_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            5:
              begin
                lblQuarterFinal_5.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_5.Font.Color := clRed;

                lblQuarterFinal_5.Show();
                lblQuarterFinal_5.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            6:
              begin
                lblQuarterFinal_6.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_6.Font.Color := clRed;

                lblQuarterFinal_6.Show();
                lblQuarterFinal_6.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            7:
              begin
                lblQuarterFinal_7.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_7.Font.Color := clRed;

                lblQuarterFinal_7.Show();
                lblQuarterFinal_7.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            8:
              begin
                lblQuarterFinal_8.Font.Color := clBlack;
                if fx.Eliminated then
                  lblQuarterFinal_8.Font.Color := clRed;

                lblQuarterFinal_8.Show();
                lblQuarterFinal_8.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_SemiFinal:
        begin
          case fx.StagePosition of
            1:
              begin
                lblSemiFinal_1.Font.Color := clBlack;
                if fx.Eliminated then
                  lblSemiFinal_1.Font.Color := clRed;

                lblSemiFinal_1.Show();
                lblSemiFinal_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblSemiFinal_2.Font.Color := clBlack;
                if fx.Eliminated then
                  lblSemiFinal_2.Font.Color := clRed;

                lblSemiFinal_2.Show();
                lblSemiFinal_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            3:
              begin
                lblSemiFinal_3.Font.Color := clBlack;
                if fx.Eliminated then
                  lblSemiFinal_3.Font.Color := clRed;

                lblSemiFinal_3.Show();
                lblSemiFinal_3.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            4:
              begin
                lblSemiFinal_4.Font.Color := clBlack;
                if fx.Eliminated then
                  lblSemiFinal_4.Font.Color := clRed;

                lblSemiFinal_4.Show();
                lblSemiFinal_4.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_Final:
        begin
          case fx.StagePosition of
            1:
              begin
                lblFinal_1.Font.Color := clBlack;
                if fx.Eliminated then
                  lblFinal_1.Font.Color := clRed;

                lblFinal_1.Show();
                lblFinal_1.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
            2:
              begin
                lblFinal_2.Font.Color := clBlack;
                if fx.Eliminated then
                  lblFinal_2.Font.Color := clRed;

                lblFinal_2.Show();
                lblFinal_2.Caption := g_TeamList.Teams[fx.TeamID].Name;
              end;
          end;
        end;
      LadderStage_Champion:
        begin
          lblChampion.Show();
          lblChampion.Caption := g_TeamList.Teams[fx.TeamID].Name;
        end;
    end;
  end;
end;

end.
