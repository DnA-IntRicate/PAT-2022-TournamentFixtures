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
            myCmb.ItemIndex := fx.TeamID - 1;
          end;
        LadderStage_Qualifier2:
          begin
            myCmb := g_Qualifier2CmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.TeamID - 1;
          end;
        LadderStage_QuarterFinal:
          begin
            myCmb := g_QuarterFinalCmbList[fx.StagePosition]^;
            myCmb.ItemIndex := fx.TeamID - 1;
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
        ptrFixture.TeamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_Qualifier;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := false; // TODO: Fix how this boolean is set
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
        ptrFixture.TeamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_Qualifier2;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := false; // TODO: Fix how this boolean is set
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
        ptrFixture.TeamID := myCmb.ItemIndex + 1;
        ptrFixture.LadderStage := LadderStage_QuarterFinal;
        ptrFixture.StagePosition := i;
        ptrFixture.Eliminated := false; // TODO: Fix how this boolean is set
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

procedure TForm2.ShowAdminPanel();
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

  pnlAdmin.Show();
  pnlLogin.Hide();
  ShowFixtures();
end;

end.
