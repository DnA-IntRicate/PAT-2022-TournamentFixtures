// Adam Foflonker 11C
unit AdminLoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.Win.ADODB, Hash,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, MainDatabase, Vcl.Buttons,
  System.ImageList, Vcl.ImgList, Team, Fixture, JsonSerializer;

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
    dbgPlayers: TDBGrid;
    btnEye: TBitBtn;
    Button1: TButton;
    btnUpdateFixtures: TButton;
    memOut: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    function HashPasswd(const passwd: string): string;
    procedure ShowAdminPanel();
    procedure ShowLoginPanel();
    procedure btnEyeClick(Sender: TObject);
    procedure btnUpdateFixturesClick(Sender: TObject);

  public
    Database: TMainDatabase;
    Teams: array [1 .. 20] of TTeam;
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
var
  jsSerialzer: TJsonSerializer;
  sJsonStr: string;
  ostream: TStreamWriter;
begin
  if FileExists(FILE_PATH_FIXTURES_JSON) then
  begin
    jsSerialzer := TJsonSerializer.Create();

    try
      sJsonStr := jsSerialzer.SerializeJson(Fixtures);
    except
      on e: Exception do
        MessageDlg('Serializing to json failed! - ' + e.Message, mtError, [mbOk], 0);
    end;

    ostream := TStreamWriter.Create(FILE_PATH_FIXTURES_JSON, false,
      TEncoding.UTF8, SizeOf(char) * sJsonStr.Length);

    ostream.Write(sJsonStr);
    ostream.Close();
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
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

procedure TForm2.ShowAdminPanel();
var
  newColumn: TColumn;
  arrFields: TStrings;
  // myDsAdmins: TDataSet;
  i: integer;
begin
  // dbgPlayers.DataSource := DataModule1.dsAdmins;
  pnlLogin.Hide();
  pnlAdmin.Show();

end;

procedure TForm2.ShowLoginPanel();
begin
  pnlAdmin.Hide();
  pnlLogin.Show();

  edtPassword.PasswordChar := '•';

  g_PasswordShowingIcon := TBitmap.Create(25, 25);
  g_PasswordShowingIcon.LoadFromFile(ICON_PATH_PASSWORDSHOWING);

  g_PasswordHidingIcon := TBitmap.Create(25, 25);
  g_PasswordHidingIcon.LoadFromFile(ICON_PATH_PASSWORDHIDING);

  btnEye.Glyph := g_PasswordHidingIcon;
end;

end.
