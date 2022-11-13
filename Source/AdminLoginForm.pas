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
    cbxEliminatedQualifier_1: TCheckBox;
    cbxEliminatedQualifier_2: TCheckBox;
    cbxEliminatedQualifier_3: TCheckBox;
    cbxEliminatedQualifier_4: TCheckBox;
    cbxEliminatedQualifier_5: TCheckBox;
    cbxEliminatedQualifier_6: TCheckBox;
    cbxEliminatedQualifier_7: TCheckBox;
    cbxEliminatedQualifier_8: TCheckBox;
    cbxEliminatedQualifier_9: TCheckBox;
    cbxEliminatedQualifier_10: TCheckBox;
    cbxEliminatedQualifier_11: TCheckBox;
    cbxEliminatedQualifier_12: TCheckBox;
    cbxEliminatedQualifier_13: TCheckBox;
    cbxEliminatedQualifier_14: TCheckBox;
    cbxEliminatedQualifier_15: TCheckBox;
    cbxEliminatedQualifier_16: TCheckBox;
    cbxEliminatedQualifier_17: TCheckBox;
    cbxEliminatedQualifier_18: TCheckBox;
    cbxEliminatedQualifier_19: TCheckBox;
    cbxEliminatedQualifier_20: TCheckBox;
    gbxEliminatedQualifier2Teams: TGroupBox;
    cbxEliminatedQualifier2_1: TCheckBox;
    cbxEliminatedQualifier2_2: TCheckBox;
    cbxEliminatedQualifier2_3: TCheckBox;
    cbxEliminatedQualifier2_4: TCheckBox;
    cbxEliminatedQualifier2_5: TCheckBox;
    cbxEliminatedQualifier2_6: TCheckBox;
    cbxEliminatedQualifier2_7: TCheckBox;
    cbxEliminatedQualifier2_8: TCheckBox;
    cbxEliminatedQualifier2_9: TCheckBox;
    cbxEliminatedQualifier2_10: TCheckBox;
    cbxEliminatedQualifier2_11: TCheckBox;
    cbxEliminatedQualifier2_12: TCheckBox;
    cbxEliminatedQualifier2_13: TCheckBox;
    cbxEliminatedQualifier2_14: TCheckBox;
    cbxEliminatedQualifier2_15: TCheckBox;
    cbxEliminatedQualifier2_16: TCheckBox;
    cbxEliminatedQualifier2_17: TCheckBox;
    cbxEliminatedQualifier2_18: TCheckBox;
    cbxEliminatedQualifier2_19: TCheckBox;
    cbxEliminatedQualifier2_20: TCheckBox;
    cmbSemiFinal_1: TComboBox;
    cmbSemiFinal_2: TComboBox;
    cmbSemiFinal_3: TComboBox;
    cmbSemiFinal_4: TComboBox;
    gbxEliminatedQuarterFinalTeams: TGroupBox;
    cbxEliminatedQuarterFinal_1: TCheckBox;
    cbxEliminatedQuarterFinal_2: TCheckBox;
    cbxEliminatedQuarterFinal_3: TCheckBox;
    cbxEliminatedQuarterFinal_4: TCheckBox;
    cbxEliminatedQuarterFinal_5: TCheckBox;
    cbxEliminatedQuarterFinal_6: TCheckBox;
    cbxEliminatedQuarterFinal_7: TCheckBox;
    cbxEliminatedQuarterFinal_8: TCheckBox;
    cbxEliminatedQuarterFinal_9: TCheckBox;
    cbxEliminatedQuarterFinal_10: TCheckBox;
    cbxEliminatedQuarterFinal_11: TCheckBox;
    cbxEliminatedQuarterFinal_12: TCheckBox;
    cbxEliminatedQuarterFinal_13: TCheckBox;
    cbxEliminatedQuarterFinal_14: TCheckBox;
    cbxEliminatedQuarterFinal_15: TCheckBox;
    cbxEliminatedQuarterFinal_16: TCheckBox;
    cbxEliminatedQuarterFinal_17: TCheckBox;
    cbxEliminatedQuarterFinal_18: TCheckBox;
    cbxEliminatedQuarterFinal_19: TCheckBox;
    cbxEliminatedQuarterFinal_20: TCheckBox;
    gbxEliminatedSemiFinalTeams: TGroupBox;
    cbxEliminatedSemiFinal_1: TCheckBox;
    cbxEliminatedSemiFinal_2: TCheckBox;
    cbxEliminatedSemiFinal_3: TCheckBox;
    cbxEliminatedSemiFinal_4: TCheckBox;
    cbxEliminatedSemiFinal_5: TCheckBox;
    cbxEliminatedSemiFinal_6: TCheckBox;
    cbxEliminatedSemiFinal_7: TCheckBox;
    cbxEliminatedSemiFinal_8: TCheckBox;
    cbxEliminatedSemiFinal_9: TCheckBox;
    cbxEliminatedSemiFinal_10: TCheckBox;
    cbxEliminatedSemiFinal_11: TCheckBox;
    cbxEliminatedSemiFinal_12: TCheckBox;
    cbxEliminatedSemiFinal_13: TCheckBox;
    cbxEliminatedSemiFinal_14: TCheckBox;
    cbxEliminatedSemiFinal_15: TCheckBox;
    cbxEliminatedSemiFinal_16: TCheckBox;
    cbxEliminatedSemiFinal_17: TCheckBox;
    cbxEliminatedSemiFinal_18: TCheckBox;
    cbxEliminatedSemiFinal_19: TCheckBox;
    cbxEliminatedSemiFinal_20: TCheckBox;
    procedure FormCreate(Sender: TObject);
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
  g_SemiFinalCmbList: array [1 .. 4] of ^TComboBox;

  g_QualifierCbxList: array [1 .. 20] of ^TCheckBox;
  g_Qualifier2CbxList: array [1 .. 20] of ^TCheckBox;
  g_QuarterFinalCbxList: array [1 .. 20] of ^TCheckBox;
  g_SemiFinalCbxList: array [1 .. 20] of ^TCheckBox;

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
        LadderStage_SemiFinal:
          begin
            myCmb := g_SemiFinalCmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.teamID - 1;

            if fx.Eliminated then
              SetEliminated(fx.teamID, LadderStage_SemiFinal);
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

  for i := Low(g_SemiFinalCmbList) to High(g_SemiFinalCmbList) do
  begin
    if g_SemiFinalCmbList[i] <> nil then
    begin
      myCmb := g_SemiFinalCmbList[i]^;
      ptrFixture := @Fixtures.Entries[iFixtureIdx];

      if (ptrFixture <> nil) and (myCmb.ItemIndex <> -1) then
      begin
        ptrFixture.teamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_SemiFinal;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := IsEliminated(ptrFixture.teamID,
          LadderStage_SemiFinal);
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
              Result := cbxEliminatedQualifier_1.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedQualifier_2.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedQualifier_3.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedQualifier_4.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedQualifier_5.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedQualifier_6.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedQualifier_7.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedQualifier_8.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedQualifier_9.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedQualifier_10.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedQualifier_11.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedQualifier_12.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedQualifier_13.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedQualifier_14.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedQualifier_15.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedQualifier_16.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedQualifier_17.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedQualifier_18.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedQualifier_19.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedQualifier_20.Checked;
            end;
        end;
      end;
    LadderStage_Qualifier2:
      begin
        case teamID of
          1:
            begin
              Result := cbxEliminatedQualifier2_1.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedQualifier2_2.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedQualifier2_3.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedQualifier2_4.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedQualifier2_5.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedQualifier2_6.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedQualifier2_7.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedQualifier2_8.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedQualifier2_9.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedQualifier2_10.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedQualifier2_11.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedQualifier2_12.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedQualifier2_13.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedQualifier2_14.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedQualifier2_15.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedQualifier2_16.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedQualifier2_17.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedQualifier2_18.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedQualifier2_19.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedQualifier2_20.Checked;
            end;
        end;
      end;
    LadderStage_QuarterFinal:
      begin
        case teamID of
          1:
            begin
              Result := cbxEliminatedQuarterFinal_1.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedQuarterFinal_2.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedQuarterFinal_3.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedQuarterFinal_4.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedQuarterFinal_5.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedQuarterFinal_6.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedQuarterFinal_7.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedQuarterFinal_8.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedQuarterFinal_9.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedQuarterFinal_10.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedQuarterFinal_11.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedQuarterFinal_12.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedQuarterFinal_13.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedQuarterFinal_14.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedQuarterFinal_15.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedQuarterFinal_16.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedQuarterFinal_17.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedQuarterFinal_18.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedQuarterFinal_19.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedQuarterFinal_20.Checked;
            end;
        end;
      end;
    LadderStage_SemiFinal:
      begin
        case teamID of
          1:
            begin
              Result := cbxEliminatedSemiFinal_1.Checked;
            end;
          2:
            begin
              Result := cbxEliminatedSemiFinal_2.Checked;
            end;
          3:
            begin
              Result := cbxEliminatedSemiFinal_3.Checked;
            end;
          4:
            begin
              Result := cbxEliminatedSemiFinal_4.Checked;
            end;
          5:
            begin
              Result := cbxEliminatedSemiFinal_5.Checked;
            end;
          6:
            begin
              Result := cbxEliminatedSemiFinal_6.Checked;
            end;
          7:
            begin
              Result := cbxEliminatedSemiFinal_7.Checked;
            end;
          8:
            begin
              Result := cbxEliminatedSemiFinal_8.Checked;
            end;
          9:
            begin
              Result := cbxEliminatedSemiFinal_9.Checked;
            end;
          10:
            begin
              Result := cbxEliminatedSemiFinal_10.Checked;
            end;
          11:
            begin
              Result := cbxEliminatedSemiFinal_11.Checked;
            end;
          12:
            begin
              Result := cbxEliminatedSemiFinal_12.Checked;
            end;
          13:
            begin
              Result := cbxEliminatedSemiFinal_13.Checked;
            end;
          14:
            begin
              Result := cbxEliminatedSemiFinal_14.Checked;
            end;
          15:
            begin
              Result := cbxEliminatedSemiFinal_15.Checked;
            end;
          16:
            begin
              Result := cbxEliminatedSemiFinal_16.Checked;
            end;
          17:
            begin
              Result := cbxEliminatedSemiFinal_17.Checked;
            end;
          18:
            begin
              Result := cbxEliminatedSemiFinal_18.Checked;
            end;
          19:
            begin
              Result := cbxEliminatedSemiFinal_19.Checked;
            end;
          20:
            begin
              Result := cbxEliminatedSemiFinal_20.Checked;
            end;
        end;
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
              cbxEliminatedQualifier_1.Checked := true;
            end;
          2:
            begin
              cbxEliminatedQualifier_2.Checked := true;
            end;
          3:
            begin
              cbxEliminatedQualifier_3.Checked := true;
            end;
          4:
            begin
              cbxEliminatedQualifier_4.Checked := true;
            end;
          5:
            begin
              cbxEliminatedQualifier_5.Checked := true;
            end;
          6:
            begin
              cbxEliminatedQualifier_6.Checked := true;
            end;
          7:
            begin
              cbxEliminatedQualifier_7.Checked := true;
            end;
          8:
            begin
              cbxEliminatedQualifier_8.Checked := true;
            end;
          9:
            begin
              cbxEliminatedQualifier_9.Checked := true;
            end;
          10:
            begin
              cbxEliminatedQualifier_10.Checked := true;
            end;
          11:
            begin
              cbxEliminatedQualifier_11.Checked := true;
            end;
          12:
            begin
              cbxEliminatedQualifier_12.Checked := true;
            end;
          13:
            begin
              cbxEliminatedQualifier_13.Checked := true;
            end;
          14:
            begin
              cbxEliminatedQualifier_14.Checked := true;
            end;
          15:
            begin
              cbxEliminatedQualifier_15.Checked := true;
            end;
          16:
            begin
              cbxEliminatedQualifier_16.Checked := true;
            end;
          17:
            begin
              cbxEliminatedQualifier_17.Checked := true;
            end;
          18:
            begin
              cbxEliminatedQualifier_18.Checked := true;
            end;
          19:
            begin
              cbxEliminatedQualifier_19.Checked := true;
            end;
          20:
            begin
              cbxEliminatedQualifier_20.Checked := true;
            end;
        end;
      end;
    LadderStage_Qualifier2:
      begin
        case teamID of
          1:
            begin
              cbxEliminatedQualifier2_1.Checked := true;
            end;
          2:
            begin
              cbxEliminatedQualifier2_2.Checked := true;
            end;
          3:
            begin
              cbxEliminatedQualifier2_3.Checked := true;
            end;
          4:
            begin
              cbxEliminatedQualifier2_4.Checked := true;
            end;
          5:
            begin
              cbxEliminatedQualifier2_5.Checked := true;
            end;
          6:
            begin
              cbxEliminatedQualifier2_6.Checked := true;
            end;
          7:
            begin
              cbxEliminatedQualifier2_7.Checked := true;
            end;
          8:
            begin
              cbxEliminatedQualifier2_8.Checked := true;
            end;
          9:
            begin
              cbxEliminatedQualifier2_9.Checked := true;
            end;
          10:
            begin
              cbxEliminatedQualifier2_10.Checked := true;
            end;
          11:
            begin
              cbxEliminatedQualifier2_11.Checked := true;
            end;
          12:
            begin
              cbxEliminatedQualifier2_12.Checked := true;
            end;
          13:
            begin
              cbxEliminatedQualifier2_13.Checked := true;
            end;
          14:
            begin
              cbxEliminatedQualifier2_14.Checked := true;
            end;
          15:
            begin
              cbxEliminatedQualifier2_15.Checked := true;
            end;
          16:
            begin
              cbxEliminatedQualifier2_16.Checked := true;
            end;
          17:
            begin
              cbxEliminatedQualifier2_17.Checked := true;
            end;
          18:
            begin
              cbxEliminatedQualifier2_18.Checked := true;
            end;
          19:
            begin
              cbxEliminatedQualifier2_19.Checked := true;
            end;
          20:
            begin
              cbxEliminatedQualifier2_20.Checked := true;
            end;
        end;
      end;
    LadderStage_QuarterFinal:
      begin
        case teamID of
          1:
            begin
              cbxEliminatedQuarterFinal_1.Checked := true;
            end;
          2:
            begin
              cbxEliminatedQuarterFinal_2.Checked := true;
            end;
          3:
            begin
              cbxEliminatedQuarterFinal_3.Checked := true;
            end;
          4:
            begin
              cbxEliminatedQuarterFinal_4.Checked := true;
            end;
          5:
            begin
              cbxEliminatedQuarterFinal_5.Checked := true;
            end;
          6:
            begin
              cbxEliminatedQuarterFinal_6.Checked := true;
            end;
          7:
            begin
              cbxEliminatedQuarterFinal_7.Checked := true;
            end;
          8:
            begin
              cbxEliminatedQuarterFinal_8.Checked := true;
            end;
          9:
            begin
              cbxEliminatedQuarterFinal_9.Checked := true;
            end;
          10:
            begin
              cbxEliminatedQuarterFinal_10.Checked := true;
            end;
          11:
            begin
              cbxEliminatedQuarterFinal_11.Checked := true;
            end;
          12:
            begin
              cbxEliminatedQuarterFinal_12.Checked := true;
            end;
          13:
            begin
              cbxEliminatedQuarterFinal_13.Checked := true;
            end;
          14:
            begin
              cbxEliminatedQuarterFinal_14.Checked := true;
            end;
          15:
            begin
              cbxEliminatedQuarterFinal_15.Checked := true;
            end;
          16:
            begin
              cbxEliminatedQuarterFinal_16.Checked := true;
            end;
          17:
            begin
              cbxEliminatedQuarterFinal_17.Checked := true;
            end;
          18:
            begin
              cbxEliminatedQuarterFinal_18.Checked := true;
            end;
          19:
            begin
              cbxEliminatedQuarterFinal_19.Checked := true;
            end;
          20:
            begin
              cbxEliminatedQuarterFinal_20.Checked := true;
            end;
        end;
      end;
    LadderStage_SemiFinal:
      begin
        case teamID of
          1:
            begin
              cbxEliminatedSemiFinal_1.Checked := true;
            end;
          2:
            begin
              cbxEliminatedSemiFinal_2.Checked := true;
            end;
          3:
            begin
              cbxEliminatedSemiFinal_3.Checked := true;
            end;
          4:
            begin
              cbxEliminatedSemiFinal_4.Checked := true;
            end;
          5:
            begin
              cbxEliminatedSemiFinal_5.Checked := true;
            end;
          6:
            begin
              cbxEliminatedSemiFinal_6.Checked := true;
            end;
          7:
            begin
              cbxEliminatedSemiFinal_7.Checked := true;
            end;
          8:
            begin
              cbxEliminatedSemiFinal_8.Checked := true;
            end;
          9:
            begin
              cbxEliminatedSemiFinal_9.Checked := true;
            end;
          10:
            begin
              cbxEliminatedSemiFinal_10.Checked := true;
            end;
          11:
            begin
              cbxEliminatedSemiFinal_11.Checked := true;
            end;
          12:
            begin
              cbxEliminatedSemiFinal_12.Checked := true;
            end;
          13:
            begin
              cbxEliminatedSemiFinal_13.Checked := true;
            end;
          14:
            begin
              cbxEliminatedSemiFinal_14.Checked := true;
            end;
          15:
            begin
              cbxEliminatedSemiFinal_15.Checked := true;
            end;
          16:
            begin
              cbxEliminatedSemiFinal_16.Checked := true;
            end;
          17:
            begin
              cbxEliminatedSemiFinal_17.Checked := true;
            end;
          18:
            begin
              cbxEliminatedSemiFinal_18.Checked := true;
            end;
          19:
            begin
              cbxEliminatedSemiFinal_19.Checked := true;
            end;
          20:
            begin
              cbxEliminatedSemiFinal_20.Checked := true;
            end;
        end;
      end;
    LadderStage_Final:
      begin

      end;
  end;
end;

procedure TForm2.ShowAdminPanel();
var
  t: TTeam;
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

  g_SemiFinalCmbList[1] := @cmbSemiFinal_1;
  g_SemiFinalCmbList[2] := @cmbSemiFinal_2;
  g_SemiFinalCmbList[3] := @cmbSemiFinal_3;
  g_SemiFinalCmbList[4] := @cmbSemiFinal_4;

  g_QualifierCbxList[1] := @cbxEliminatedQualifier_1;
  g_QualifierCbxList[2] := @cbxEliminatedQualifier_2;
  g_QualifierCbxList[3] := @cbxEliminatedQualifier_3;
  g_QualifierCbxList[4] := @cbxEliminatedQualifier_4;
  g_QualifierCbxList[5] := @cbxEliminatedQualifier_5;
  g_QualifierCbxList[6] := @cbxEliminatedQualifier_6;
  g_QualifierCbxList[7] := @cbxEliminatedQualifier_7;
  g_QualifierCbxList[8] := @cbxEliminatedQualifier_8;
  g_QualifierCbxList[9] := @cbxEliminatedQualifier_9;
  g_QualifierCbxList[10] := @cbxEliminatedQualifier_10;
  g_QualifierCbxList[11] := @cbxEliminatedQualifier_11;
  g_QualifierCbxList[12] := @cbxEliminatedQualifier_12;
  g_QualifierCbxList[13] := @cbxEliminatedQualifier_13;
  g_QualifierCbxList[14] := @cbxEliminatedQualifier_14;
  g_QualifierCbxList[15] := @cbxEliminatedQualifier_15;
  g_QualifierCbxList[16] := @cbxEliminatedQualifier_16;
  g_QualifierCbxList[17] := @cbxEliminatedQualifier_17;
  g_QualifierCbxList[18] := @cbxEliminatedQualifier_18;
  g_QualifierCbxList[19] := @cbxEliminatedQualifier_19;
  g_QualifierCbxList[20] := @cbxEliminatedQualifier_20;

  g_Qualifier2CbxList[1] := @cbxEliminatedQualifier2_1;
  g_Qualifier2CbxList[2] := @cbxEliminatedQualifier2_2;
  g_Qualifier2CbxList[3] := @cbxEliminatedQualifier2_3;
  g_Qualifier2CbxList[4] := @cbxEliminatedQualifier2_4;
  g_Qualifier2CbxList[5] := @cbxEliminatedQualifier2_5;
  g_Qualifier2CbxList[6] := @cbxEliminatedQualifier2_6;
  g_Qualifier2CbxList[7] := @cbxEliminatedQualifier2_7;
  g_Qualifier2CbxList[8] := @cbxEliminatedQualifier2_8;
  g_Qualifier2CbxList[9] := @cbxEliminatedQualifier2_9;
  g_Qualifier2CbxList[10] := @cbxEliminatedQualifier2_10;
  g_Qualifier2CbxList[11] := @cbxEliminatedQualifier2_11;
  g_Qualifier2CbxList[12] := @cbxEliminatedQualifier2_12;
  g_Qualifier2CbxList[13] := @cbxEliminatedQualifier2_13;
  g_Qualifier2CbxList[14] := @cbxEliminatedQualifier2_14;
  g_Qualifier2CbxList[15] := @cbxEliminatedQualifier2_15;
  g_Qualifier2CbxList[16] := @cbxEliminatedQualifier2_16;
  g_Qualifier2CbxList[17] := @cbxEliminatedQualifier2_17;
  g_Qualifier2CbxList[18] := @cbxEliminatedQualifier2_18;
  g_Qualifier2CbxList[19] := @cbxEliminatedQualifier2_19;
  g_Qualifier2CbxList[20] := @cbxEliminatedQualifier2_20;

  g_QuarterFinalCbxList[1] := @cbxEliminatedQuarterFinal_1;
  g_QuarterFinalCbxList[2] := @cbxEliminatedQuarterFinal_2;
  g_QuarterFinalCbxList[3] := @cbxEliminatedQuarterFinal_3;
  g_QuarterFinalCbxList[4] := @cbxEliminatedQuarterFinal_4;
  g_QuarterFinalCbxList[5] := @cbxEliminatedQuarterFinal_5;
  g_QuarterFinalCbxList[6] := @cbxEliminatedQuarterFinal_6;
  g_QuarterFinalCbxList[7] := @cbxEliminatedQuarterFinal_7;
  g_QuarterFinalCbxList[8] := @cbxEliminatedQuarterFinal_8;
  g_QuarterFinalCbxList[9] := @cbxEliminatedQuarterFinal_9;
  g_QuarterFinalCbxList[10] := @cbxEliminatedQuarterFinal_10;
  g_QuarterFinalCbxList[11] := @cbxEliminatedQuarterFinal_11;
  g_QuarterFinalCbxList[12] := @cbxEliminatedQuarterFinal_12;
  g_QuarterFinalCbxList[13] := @cbxEliminatedQuarterFinal_13;
  g_QuarterFinalCbxList[14] := @cbxEliminatedQuarterFinal_14;
  g_QuarterFinalCbxList[15] := @cbxEliminatedQuarterFinal_15;
  g_QuarterFinalCbxList[16] := @cbxEliminatedQuarterFinal_16;
  g_QuarterFinalCbxList[17] := @cbxEliminatedQuarterFinal_17;
  g_QuarterFinalCbxList[18] := @cbxEliminatedQuarterFinal_18;
  g_QuarterFinalCbxList[19] := @cbxEliminatedQuarterFinal_19;
  g_QuarterFinalCbxList[20] := @cbxEliminatedQuarterFinal_20;

  g_SemiFinalCbxList[1] := @cbxEliminatedSemiFinal_1;
  g_SemiFinalCbxList[2] := @cbxEliminatedSemiFinal_2;
  g_SemiFinalCbxList[3] := @cbxEliminatedSemiFinal_3;
  g_SemiFinalCbxList[4] := @cbxEliminatedSemiFinal_4;
  g_SemiFinalCbxList[5] := @cbxEliminatedSemiFinal_5;
  g_SemiFinalCbxList[6] := @cbxEliminatedSemiFinal_6;
  g_SemiFinalCbxList[7] := @cbxEliminatedSemiFinal_7;
  g_SemiFinalCbxList[8] := @cbxEliminatedSemiFinal_8;
  g_SemiFinalCbxList[9] := @cbxEliminatedSemiFinal_9;
  g_SemiFinalCbxList[10] := @cbxEliminatedSemiFinal_10;
  g_SemiFinalCbxList[11] := @cbxEliminatedSemiFinal_11;
  g_SemiFinalCbxList[12] := @cbxEliminatedSemiFinal_12;
  g_SemiFinalCbxList[13] := @cbxEliminatedSemiFinal_13;
  g_SemiFinalCbxList[14] := @cbxEliminatedSemiFinal_14;
  g_SemiFinalCbxList[15] := @cbxEliminatedSemiFinal_15;
  g_SemiFinalCbxList[16] := @cbxEliminatedSemiFinal_16;
  g_SemiFinalCbxList[17] := @cbxEliminatedSemiFinal_17;
  g_SemiFinalCbxList[18] := @cbxEliminatedSemiFinal_18;
  g_SemiFinalCbxList[19] := @cbxEliminatedSemiFinal_19;
  g_SemiFinalCbxList[20] := @cbxEliminatedSemiFinal_20;

  for t in TeamList.Teams do
  begin
    for i := Low(g_QualifierCmbList) to High(g_QualifierCmbList) do
      g_QualifierCmbList[i].Items.Add(t.Name);

    for i := Low(g_Qualifier2CmbList) to High(g_Qualifier2CmbList) do
      g_Qualifier2CmbList[i].Items.Add(t.Name);

    for i := Low(g_QuarterFinalCmbList) to High(g_QuarterFinalCmbList) do
      g_QuarterFinalCmbList[i].Items.Add(t.Name);

    for i := Low(g_SemiFinalCmbList) to High(g_SemiFinalCmbList) do
      g_SemiFinalCmbList[i].Items.Add(t.Name);
  end;

  for i := Low(g_QualifierCbxList) to High(g_QualifierCbxList) do
    g_QualifierCbxList[i].Caption := TeamList.Teams[i].Name;

  for i := Low(g_Qualifier2CbxList) to High(g_Qualifier2CbxList) do
    g_Qualifier2CbxList[i].Caption := TeamList.Teams[i].Name;

  for i := Low(g_QuarterFinalCbxList) to High(g_QuarterFinalCbxList) do
    g_QuarterFinalCbxList[i].Caption := TeamList.Teams[i].Name;

  for i := Low(g_SemiFinalCbxList) to High(g_SemiFinalCbxList) do
    g_SemiFinalCbxList[i].Caption := TeamList.Teams[i].Name;

  pnlAdmin.Show();
  pnlLogin.Hide();
  ShowFixtures();
end;

end.
