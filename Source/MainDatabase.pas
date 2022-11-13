// Adam Foflonker 11C
unit MainDatabase;

interface

uses
  System.SysUtils, Data.DB, Data.Win.ADODB;

type
  TMainDatabase = class
  public
    Connection: TADOConnection;
    TblAdmins: TADOTable;
    TblTeams: TADOTable;

  const
    TBL_NAME_ADMINS = 'tblAdmins';
    TBL_NAME_TEAMS = 'tblTeams';
    TBL_NAME_PLAYERS = 'tblPlayers';

    constructor Create();
  end;

implementation

constructor TMainDatabase.Create;
begin
  Connection := TADOConnection.Create(nil);
  Connection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=Assets/Database.mdb;Mode=ReadWrite';

  Connection.Mode := cmReadWrite;
  Connection.LoginPrompt := false;
  Connection.Open();

  TblAdmins := TADOTable.Create(nil);
  TblAdmins.Connection := Connection;
  TblAdmins.TableName := TBL_NAME_ADMINS;

  TblTeams := TADOTable.Create(nil);
  TblTeams.Connection := Connection;
  TblTeams.TableName := TBL_NAME_TEAMS;
end;

end.
