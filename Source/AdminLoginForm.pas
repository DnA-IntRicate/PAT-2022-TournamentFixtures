// Adam Foflonker 11C
unit AdminLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.Win.ADODB, Hash,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, MainDatabase, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, Team, Fixture, JsonSerializer,
  Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    edtForenames: TEdit;
    Label1: TLabel;
    edtSurname: TEdit;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    btnLogin: TButton;
    pnlLogin: TPanel;
    pnlAdmin: TPanel;
    btnEye: TBitBtn;
    Button1: TButton;
    btnUpdateFixtures: TButton;
    pnlFixtures: TPanel;
    imgLadder: TImage;
    cmbQualifier_1: TComboBox;
    cmbQualifier_2: TComboBox;
    cmbQualifier_5: TComboBox;
    cmbQualifier_20: TComboBox;
    cmbQualifier_13: TComboBox;
    cmbQualifier_4: TComboBox;
    cmbQualifier_9: TComboBox;
    cmbQualifier_8: TComboBox;
    cmbQualifier_17: TComboBox;
    cmbQualifier_16: TComboBox;
    cmbQualifier_12: TComboBox;
    cmbQualifier_18: TComboBox;
    cmbQualifier_15: TComboBox;
    cmbQualifier_19: TComboBox;
    cmbQualifier_14: TComboBox;
    cmbQualifier_7: TComboBox;
    cmbQualifier_10: TComboBox;
    cmbQualifier_3: TComboBox;
    cmbQualifier_6: TComboBox;
    cmbQualifier_11: TComboBox;
    cmbQualifier2_4: TComboBox;
    cmbQualifier2_1: TComboBox;
    cmbQualifier2_3: TComboBox;
    cmbQualifier2_2: TComboBox;
    cmbQuarterFinal_1: TComboBox;
    cmbQuarterFinal_2: TComboBox;
    cmbQuarterFinal_3: TComboBox;
    cmbQuarterFinal_4: TComboBox;
    cmbQuarterFinal_5: TComboBox;
    cmbQuarterFinal_6: TComboBox;
    cmbQuarterFinal_7: TComboBox;
    cmbQuarterFinal_8: TComboBox;
    gbxEliminatedQualifierTeams: TGroupBox;
    cbxEliminatedQualifier_8A: TCheckBox;
    cbxEliminatedQualifier_8C: TCheckBox;
    cbxEliminatedQualifier_8D: TCheckBox;
    cbxEliminatedQualifier_8B: TCheckBox;
    cbxEliminatedQualifier_9B: TCheckBox;
    cbxEliminatedQualifier_9C: TCheckBox;
    cbxEliminatedQualifier_9D: TCheckBox;
    cbxEliminatedQualifier_9A: TCheckBox;
    cbxEliminatedQualifier_10A: TCheckBox;
    cbxEliminatedQualifier_10B: TCheckBox;
    cbxEliminatedQualifier_10C: TCheckBox;
    cbxEliminatedQualifier_10D: TCheckBox;
    cbxEliminatedQualifier_11A: TCheckBox;
    cbxEliminatedQualifier_11B: TCheckBox;
    cbxEliminatedQualifier_11C: TCheckBox;
    cbxEliminatedQualifier_11D: TCheckBox;
    cbxEliminatedQualifier_12A: TCheckBox;
    cbxEliminatedQualifier_12B: TCheckBox;
    cbxEliminatedQualifier_12C: TCheckBox;
    cbxEliminatedQualifier_12D: TCheckBox;
    gbxEliminatedQualifier2Teams: TGroupBox;
    cbxEliminatedQualifier2_8A: TCheckBox;
    cbxEliminatedQualifier2_8b: TCheckBox;
    cbxEliminatedQualifier2_8C: TCheckBox;
    cbxEliminatedQualifier2_8D: TCheckBox;
    cbxEliminatedQualifier2_9A: TCheckBox;
    cbxEliminatedQualifier2_9B: TCheckBox;
    cbxEliminatedQualifier2_9C: TCheckBox;
    cbxEliminatedQualifier2_9D: TCheckBox;
    cbxEliminatedQualifier2_10A: TCheckBox;
    cbxEliminatedQualifier2_10B: TCheckBox;
    cbxEliminatedQualifier2_10C: TCheckBox;
    cbxEliminatedQualifier2_10D: TCheckBox;
    cbxEliminatedQualifier2_11A: TCheckBox;
    cbxEliminatedQualifier2_11B: TCheckBox;
    cbxEliminatedQualifier2_11C: TCheckBox;
    cbxEliminatedQualifier2_11D: TCheckBox;
    cbxEliminatedQualifier2_12A: TCheckBox;
    cbxEliminatedQualifier2_12B: TCheckBox;
    cbxEliminatedQualifier2_12C: TCheckBox;
    cbxEliminatedQualifier2_12D: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    function HashPasswd(const passwd: string): string;
    procedure ShowLoginPanel();
    procedure ShowAdminPanel();
    procedure btnEyeClick(Sender: TObject);
    procedure btnUpdateFixturesClick(Sender: TObject);
    procedure ShowFixtures();
    procedure UpdateFixtures();
    function IsEliminated(const teamID: integer; const stage: integer): boolean;
    procedure SetEliminated(const teamID: integer; const stage: integer);

  public
    Database: TMainDatabase;
    TeamList: TTeamList;
    Fixtures: TFixtures;
  end;

const
  TBL_ADMINS_FIELD_NAME_FORENAMES = 'Forenames';
  TBL_ADMINS_FIELD_NAME_SURNAME = 'Surname';
  TBL_ADMINS_FIELD_NAME_PASSWORDHASH = 'PasswordHash';

  ICON_PATH_PASSWORDSHOWING = 'Assets/Images/PasswordShowingIconSmall.bmp';
  ICON_PATH_PASSWORDHIDING = 'Assets/Images/PasswordHidingIconSmall.bmp';

  FILE_PATH_FIXTURES_JSON = 'Fixtures.json';

var
  Form2: TForm2;
  g_PasswordShowingIcon, g_PasswordHidingIcon: TBitmap;
  g_QualifierCmbList: array [1 .. 20] of ^TComboBox;
  g_Qualifier2CmbList: array [1 .. 4] of ^TComboBox;
  g_QuarterFinalCmbList: array [1 .. 8] of ^TComboBox;

  g_QualifierCbxList: array [1 .. 20] of ^TCheckBox;
  g_Qualifier2CbxList: array [1 .. 20] of ^TCheckBox;

implementation

{$R *.dfm}

procedure TForm2.btnEyeClick(Sender: TObject);
begin
  if edtPassword.PasswordChar = #0 then
  begin
    edtPassword.PasswordChar := '•';
    btnEye.Glyph := g_PasswordHidingIcon;
  end
  else
  begin
    edtPassword.PasswordChar := #0;
    btnEye.Glyph := g_PasswordShowingIcon;
  end;
end;

procedure TForm2.btnLoginClick(Sender: TObject);
var
  sForenames, sSurname, sPassword: string;
  bEntryFound: boolean;
  i: integer;
  tblAdmins: TADOTable;
begin
  sForenames := edtForenames.Text;
  sSurname := edtSurname.Text;
  sPassword := edtPassword.Text;

  tblAdmins := Database.tblAdmins;
  tblAdmins.Open();
  tblAdmins.First();

  bEntryFound := false;
  for i := 0 to tblAdmins.RecordCount do
  begin
    if sForenames = tblAdmins[TBL_ADMINS_FIELD_NAME_FORENAMES] then
    begin
      bEntryFound := true;
      break;
    end;

    tblAdmins.Next();
  end;

  if bEntryFound then
  begin
    if sSurname = tblAdmins[TBL_ADMINS_FIELD_NAME_SURNAME] then
    begin
      if HashPasswd(sPassword) = tblAdmins[TBL_ADMINS_FIELD_NAME_PASSWORDHASH]
      then
      begin
        ShowMessage(Format('Welcome %s %s.', [sForenames, sSurname]));
        ShowAdminPanel();
      end
      else
      begin
        ShowMessage('Incorrect password!');
        edtPassword.SetFocus();
      end;

    end
    else
    begin
      ShowMessage('Incorrect surname!');
      edtSurname.SetFocus();
    end;

  end
  else
  begin
    ShowMessage('Admin does not exist!');
    edtForenames.SetFocus();
  end;
end;

procedure TForm2.btnUpdateFixturesClick(Sender: TObject);
begin
  UpdateFixtures();
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  g_PasswordShowingIcon := TBitmap.Create(25, 25);
  g_PasswordShowingIcon.LoadFromFile(ICON_PATH_PASSWORDSHOWING);

  g_PasswordHidingIcon := TBitmap.Create(25, 25);
  g_PasswordHidingIcon.LoadFromFile(ICON_PATH_PASSWORDHIDING);

  ShowLoginPanel();
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  //
end;

function TForm2.HashPasswd(const passwd: string): string;
var
  MD5: THashMD5;
  sHash: string;
begin
  MD5 := THashMD5.Create();

  sHash := MD5.GetHashString(passwd);
  sHash := sHash.Insert(Length(passwd),
    MD5.GetHashString(IntToStr(Length(passwd))));
  sHash := MD5.GetHashString(sHash) + '==';

  Result := sHash;
end;

procedure TForm2.ShowFixtures();
var
  myCmb: TComboBox;
  fx: TFixture;
begin
  for fx in Fixtures.Entries do
  begin
    if fx.StagePosition > 0 then
      case fx.LadderStage of
        LadderStage_Disqualified:
          begin

          end;
        LadderStage_Qualifier:
          begin
            myCmb := g_QualifierCmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.teamID - 1;

            if fx.Eliminated then
              SetEliminated(fx.teamID, LadderStage_Qualifier);
          end;
        LadderStage_Qualifier2:
          begin
            myCmb := g_Qualifier2CmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.teamID - 1;

            if fx.Eliminated then
              SetEliminated(fx.teamID, LadderStage_Qualifier2);
          end;
        LadderStage_QuarterFinal:
          begin
            myCmb := g_QuarterFinalCmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.teamID - 1;

            if fx.Eliminated then
              SetEliminated(fx.teamID, LadderStage_QuarterFinal);
          end;
      end;
  end;
end;

procedure TForm2.ShowLoginPanel();
begin
  pnlAdmin.Hide();
  pnlLogin.Show();

  edtPassword.PasswordChar := '•';
  btnEye.Glyph := g_PasswordHidingIcon;
end;

procedure TForm2.UpdateFixtures();
var
  i, iFixtureIdx: integer;
  myCmb: TComboBox;
  ptrFixture: ^TFixture;
  jsSerialzer: TJsonSerializer;
  sJsonStr: string;
  ostream: TStreamWriter;
begin
  iFixtureIdx := 1;

  for i := Low(g_QualifierCmbList) to High(g_QualifierCmbList) do
  begin
    if g_QualifierCmbList[i] <> nil then
    begin
      myCmb := g_QualifierCmbList[i]^;
      ptrFixture := @Fixtures.Entries[iFixtureIdx];

      if (ptrFixture <> nil) and (myCmb.ItemIndex <> -1) then
      begin
        ptrFixture.teamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_Qualifier;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := IsEliminated(ptrFixture.teamID,
          LadderStage_Qualifier);
      end;
    end;

    Inc(iFixtureIdx, 1);
  end;

  for i := Low(g_Qualifier2CmbList) to High(g_Qualifier2CmbList) do
  begin
    if g_Qualifier2CmbList[i] <> nil then
    begin
      myCmb := g_Qualifier2CmbList[i]^;
      ptrFixture := @Fixtures.Entries[iFixtureIdx];

      if (ptrFixture <> nil) and (myCmb.ItemIndex <> -1) then
      begin
        ptrFixture.teamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_Qualifier2;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := IsEliminated(ptrFixture.teamID,
          LadderStage_Qualifier2);
      end;
    end;

    Inc(iFixtureIdx, 1);
  end;

  for i := Low(g_QuarterFinalCmbList) to High(g_QuarterFinalCmbList) do
  begin
    if g_QuarterFinalCmbList[i] <> nil then
    begin
      myCmb := g_QuarterFinalCmbList[i]^;
      ptrFixture := @Fixtures.Entries[iFixtureIdx];

      if (ptrFixture <> nil) and (myCmb.ItemIndex <> -1) then
      begin
        ptrFixture.teamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_QuarterFinal;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := IsEliminated(ptrFixture.teamID,
          LadderStage_QuarterFinal);
      end;
    end;

    Inc(iFixtureIdx, 1);
  end;

  if FileExists(FILE_PATH_FIXTURES_JSON) then
  begin
    jsSerialzer := TJsonSerializer.Create();

    try
      sJsonStr := jsSerialzer.SerializeJson(Fixtures);
    except
      on e: Exception do
        MessageDlg('Serializing to json failed! - ' + e.Message, mtError,
          [mbOk], 0);
    end;

    ostream := TStreamWriter.Create(FILE_PATH_FIXTURES_JSON, false,
      TEncoding.UTF8, SizeOf(char) * sJsonStr.Length);

    ostream.Write(sJsonStr);
    ostream.Close();
  end;
end;

function TForm2.IsEliminated(const teamID: integer;
  const stage: integer): boolean;
begin
  case stage of
    LadderStage_Disqualified:
      begin
        Result := true;
      end;
    LadderStage_Qualifier:
      begin
        case teamID of
          1:
            begin
              Result := cbxEliminatedQualifier_8A.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedQualifier_8B.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedQualifier_8C.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedQualifier_8D.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedQualifier_9A.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedQualifier_9B.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedQualifier_9C.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedQualifier_9D.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedQualifier_10A.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedQualifier_10B.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedQualifier_10C.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedQualifier_10D.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedQualifier_11A.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedQualifier_11B.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedQualifier_11C.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedQualifier_11D.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedQualifier_12A.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedQualifier_12B.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedQualifier_12C.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedQualifier_12D.Checked;
            end;
        end;
      end;
    LadderStage_Qualifier2:
      begin
        case teamID of
          1:
            begin
              Result := cbxEliminatedQualifier2_8A.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedQualifier2_8b.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedQualifier2_8C.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedQualifier2_8D.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedQualifier2_9A.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedQualifier2_9B.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedQualifier2_9C.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedQualifier2_9D.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedQualifier2_10A.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedQualifier2_10B.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedQualifier2_10C.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedQualifier2_10D.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedQualifier2_11A.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedQualifier2_11B.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedQualifier2_11C.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedQualifier2_11D.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedQualifier2_12A.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedQualifier2_12B.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedQualifier2_12C.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedQualifier2_12D.Checked;
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
        Result := false;
      end;
  else
    begin
      Result := false;
    end;
  end;
end;

procedure TForm2.SetEliminated(const teamID: integer; const stage: integer);
begin
  case stage of
    LadderStage_Qualifier:
      begin
        case teamID of
          1:
            begin
              cbxEliminatedQualifier_8A.Checked := true;
            end;
          2:
            begin
              cbxEliminatedQualifier_8B.Checked := true;
            end;
          3:
            begin
              cbxEliminatedQualifier_8C.Checked := true;
            end;
          4:
            begin
              cbxEliminatedQualifier_8D.Checked := true;
            end;
          5:
            begin
              cbxEliminatedQualifier_9A.Checked := true;
            end;
          6:
            begin
              cbxEliminatedQualifier_9B.Checked := true;
            end;
          7:
            begin
              cbxEliminatedQualifier_9C.Checked := true;
            end;
          8:
            begin
              cbxEliminatedQualifier_9D.Checked := true;
            end;
          9:
            begin
              cbxEliminatedQualifier_10A.Checked := true;
            end;
          10:
            begin
              cbxEliminatedQualifier_10B.Checked := true;
            end;
          11:
            begin
              cbxEliminatedQualifier_10C.Checked := true;
            end;
          12:
            begin
              cbxEliminatedQualifier_10D.Checked := true;
            end;
          13:
            begin
              cbxEliminatedQualifier_11A.Checked := true;
            end;
          14:
            begin
              cbxEliminatedQualifier_11B.Checked := true;
            end;
          15:
            begin
              cbxEliminatedQualifier_11C.Checked := true;
            end;
          16:
            begin
              cbxEliminatedQualifier_11D.Checked := true;
            end;
          17:
            begin
              cbxEliminatedQualifier_12A.Checked := true;
            end;
          18:
            begin
              cbxEliminatedQualifier_12B.Checked := true;
            end;
          19:
            begin
              cbxEliminatedQualifier_12C.Checked := true;
            end;
          20:
            begin
              cbxEliminatedQualifier_12D.Checked := true;
            end;
        end;
      end;
    LadderStage_Qualifier2:
      begin
        case teamID of
          1:
            begin
              cbxEliminatedQualifier2_8A.Checked := true;
            end;
          2:
            begin
              cbxEliminatedQualifier2_8b.Checked := true;
            end;
          3:
            begin
              cbxEliminatedQualifier2_8C.Checked := true;
            end;
          4:
            begin
              cbxEliminatedQualifier2_8D.Checked := true;
            end;
          5:
            begin
              cbxEliminatedQualifier2_9A.Checked := true;
            end;
          6:
            begin
              cbxEliminatedQualifier2_9B.Checked := true;
            end;
          7:
            begin
              cbxEliminatedQualifier2_9C.Checked := true;
            end;
          8:
            begin
              cbxEliminatedQualifier2_9D.Checked := true;
            end;
          9:
            begin
              cbxEliminatedQualifier2_10A.Checked := true;
            end;
          10:
            begin
              cbxEliminatedQualifier2_10B.Checked := true;
            end;
          11:
            begin
              cbxEliminatedQualifier2_10C.Checked := true;
            end;
          12:
            begin
              cbxEliminatedQualifier2_10D.Checked := true;
            end;
          13:
            begin
              cbxEliminatedQualifier2_11A.Checked := true;
            end;
          14:
            begin
              cbxEliminatedQualifier2_11B.Checked := true;
            end;
          15:
            begin
              cbxEliminatedQualifier2_11C.Checked := true;
            end;
          16:
            begin
              cbxEliminatedQualifier2_11D.Checked := true;
            end;
          17:
            begin
              cbxEliminatedQualifier2_12A.Checked := true;
            end;
          18:
            begin
              cbxEliminatedQualifier2_12B.Checked := true;
            end;
          19:
            begin
              cbxEliminatedQualifier2_12C.Checked := true;
            end;
          20:
            begin
              cbxEliminatedQualifier2_12D.Checked := true;
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
  end;
end;

procedure TForm2.ShowAdminPanel();
var
  Team: TTeam;
  i: integer;
begin
  g_QualifierCmbList[1] := @cmbQualifier_1;
  g_QualifierCmbList[2] := @cmbQualifier_2;
  g_QualifierCmbList[3] := @cmbQualifier_3;
  g_QualifierCmbList[4] := @cmbQualifier_4;
  g_QualifierCmbList[5] := @cmbQualifier_5;
  g_QualifierCmbList[6] := @cmbQualifier_6;
  g_QualifierCmbList[7] := @cmbQualifier_7;
  g_QualifierCmbList[8] := @cmbQualifier_8;
  g_QualifierCmbList[9] := @cmbQualifier_9;
  g_QualifierCmbList[10] := @cmbQualifier_10;
  g_QualifierCmbList[11] := @cmbQualifier_11;
  g_QualifierCmbList[12] := @cmbQualifier_12;
  g_QualifierCmbList[13] := @cmbQualifier_13;
  g_QualifierCmbList[14] := @cmbQualifier_14;
  g_QualifierCmbList[15] := @cmbQualifier_15;
  g_QualifierCmbList[16] := @cmbQualifier_16;
  g_QualifierCmbList[17] := @cmbQualifier_17;
  g_QualifierCmbList[18] := @cmbQualifier_18;
  g_QualifierCmbList[19] := @cmbQualifier_19;
  g_QualifierCmbList[20] := @cmbQualifier_20;

  g_Qualifier2CmbList[1] := @cmbQualifier2_1;
  g_Qualifier2CmbList[2] := @cmbQualifier2_2;
  g_Qualifier2CmbList[3] := @cmbQualifier2_3;
  g_Qualifier2CmbList[4] := @cmbQualifier2_4;

  g_QuarterFinalCmbList[1] := @cmbQuarterFinal_1;
  g_QuarterFinalCmbList[2] := @cmbQuarterFinal_2;
  g_QuarterFinalCmbList[3] := @cmbQuarterFinal_3;
  g_QuarterFinalCmbList[4] := @cmbQuarterFinal_4;
  g_QuarterFinalCmbList[5] := @cmbQuarterFinal_5;
  g_QuarterFinalCmbList[6] := @cmbQuarterFinal_6;
  g_QuarterFinalCmbList[7] := @cmbQuarterFinal_7;
  g_QuarterFinalCmbList[8] := @cmbQuarterFinal_8;

  g_QualifierCbxList[1] := @cbxEliminatedQualifier_8A;
  g_QualifierCbxList[2] := @cbxEliminatedQualifier_8B;
  g_QualifierCbxList[3] := @cbxEliminatedQualifier_8C;
  g_QualifierCbxList[4] := @cbxEliminatedQualifier_8D;
  g_QualifierCbxList[5] := @cbxEliminatedQualifier_9A;
  g_QualifierCbxList[6] := @cbxEliminatedQualifier_9B;
  g_QualifierCbxList[7] := @cbxEliminatedQualifier_9C;
  g_QualifierCbxList[8] := @cbxEliminatedQualifier_9D;
  g_QualifierCbxList[9] := @cbxEliminatedQualifier_10A;
  g_QualifierCbxList[10] := @cbxEliminatedQualifier_10B;
  g_QualifierCbxList[11] := @cbxEliminatedQualifier_10C;
  g_QualifierCbxList[12] := @cbxEliminatedQualifier_10D;
  g_QualifierCbxList[13] := @cbxEliminatedQualifier_11A;
  g_QualifierCbxList[14] := @cbxEliminatedQualifier_11B;
  g_QualifierCbxList[15] := @cbxEliminatedQualifier_11C;
  g_QualifierCbxList[16] := @cbxEliminatedQualifier_11D;
  g_QualifierCbxList[17] := @cbxEliminatedQualifier_12A;
  g_QualifierCbxList[18] := @cbxEliminatedQualifier_12B;
  g_QualifierCbxList[19] := @cbxEliminatedQualifier_12C;
  g_QualifierCbxList[20] := @cbxEliminatedQualifier_12D;

  g_Qualifier2CbxList[1] := @cbxEliminatedQualifier2_8A;
  g_Qualifier2CbxList[2] := @cbxEliminatedQualifier2_8b;
  g_Qualifier2CbxList[3] := @cbxEliminatedQualifier2_8C;
  g_Qualifier2CbxList[4] := @cbxEliminatedQualifier2_8D;
  g_Qualifier2CbxList[5] := @cbxEliminatedQualifier2_9A;
  g_Qualifier2CbxList[6] := @cbxEliminatedQualifier2_9B;
  g_Qualifier2CbxList[7] := @cbxEliminatedQualifier2_9C;
  g_Qualifier2CbxList[8] := @cbxEliminatedQualifier2_9D;
  g_Qualifier2CbxList[9] := @cbxEliminatedQualifier2_10A;
  g_Qualifier2CbxList[10] := @cbxEliminatedQualifier2_10B;
  g_Qualifier2CbxList[11] := @cbxEliminatedQualifier2_10C;
  g_Qualifier2CbxList[12] := @cbxEliminatedQualifier2_10D;
  g_Qualifier2CbxList[13] := @cbxEliminatedQualifier2_11A;
  g_Qualifier2CbxList[14] := @cbxEliminatedQualifier2_11B;
  g_Qualifier2CbxList[15] := @cbxEliminatedQualifier2_11C;
  g_Qualifier2CbxList[16] := @cbxEliminatedQualifier2_11D;
  g_Qualifier2CbxList[17] := @cbxEliminatedQualifier2_12A;
  g_Qualifier2CbxList[18] := @cbxEliminatedQualifier2_12B;
  g_Qualifier2CbxList[19] := @cbxEliminatedQualifier2_12C;
  g_Qualifier2CbxList[20] := @cbxEliminatedQualifier2_12D;

  for Team in TeamList.Teams do
  begin
    for i := Low(g_QualifierCmbList) to High(g_QualifierCmbList) do
      g_QualifierCmbList[i].Items.Add(Team.Name);

    for i := Low(g_Qualifier2CmbList) to High(g_Qualifier2CmbList) do
      g_Qualifier2CmbList[i].Items.Add(Team.Name);

    for i := Low(g_QuarterFinalCmbList) to High(g_QuarterFinalCmbList) do
      g_QuarterFinalCmbList[i].Items.Add(Team.Name);
  end;

  pnlAdmin.Show();
  pnlLogin.Hide();
  ShowFixtures();
end;

end.
