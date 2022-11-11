// Adam Foflonker 11C
unit FileStream;

interface

uses
  System.SysUtils, Winapi.Messages, Winapi.Windows, Vcl.Dialogs, System.Classes;

type
  TFileStream = class
  public
    constructor Create();
    procedure OpenFile(const FilePath: string);
    procedure CreateFile(const FilePath: string);
    function LoadFromFile(): string;
    function DirExists(const Directory: string): boolean;
    function FileExists(const FilePath: string): boolean;
    function GetFilePath(): string;
    procedure CloseFile();

  type
    TEnumWriteMode = (Append = 0, Overwrite);
  procedure SaveToFile(const Text: string; WriteMode: TEnumWriteMode);

  const
    NewLine = #13#10;
  private
    m_FilePath: string;
    m_FileContents: string;
    m_Writer: TStreamWriter;
    m_Reader: TStreamReader;
    m_TextFile: TextFile;
  end;

implementation

constructor TFileStream.Create();
begin
  m_FilePath := string.Empty;
  m_FileContents := string.Empty;
end;

procedure TFileStream.OpenFile(const FilePath: string);
begin
  if (FileExists(FilePath)) then
  begin
    m_FilePath := FilePath;
    AssignFile(m_TextFile, m_FilePath);
  end
  else
  begin
    MessageDlg('''' + FilePath + '''' + ' Does not exist! ', mtError,
      [mbOK], 0);
  end;
end;

procedure TFileStream.CreateFile(const FilePath: string);
begin
  FileCreate(FilePath);
end;

function TFileStream.LoadFromFile(): string;
var
  sLineBuffer: string;
begin
  Reset(m_TextFile);

  if FileExists(m_FilePath) then
  begin
    while not(Eof(m_TextFile)) do
    begin
      Readln(m_TextFile, sLineBuffer);
      m_FileContents := m_FileContents + sLineBuffer + NewLine;
    end;

    Result := m_FileContents;
  end
  else
  begin
    Result := 'NULL';
  end;
end;

procedure TFileStream.SaveToFile(const Text: string; WriteMode: TEnumWriteMode);
begin
  case WriteMode of
    Append:
      System.Append(m_TextFile);
    Overwrite:
      System.ReWrite(m_TextFile);
  end;

  System.Write(m_TextFile, Text);
end;

function TFileStream.DirExists(const Directory: string): boolean;
begin
  if System.SysUtils.DirectoryExists(Directory) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;
end;

function TFileStream.FileExists(const FilePath: string): boolean;
begin
  if System.SysUtils.FileExists(FilePath) then
  begin
    Result := true;
  end
  else
  begin
    Result := false;
  end;

end;

function TFileStream.GetFilePath(): string;
begin
  Result := m_FilePath;
end;

procedure TFileStream.CloseFile();
begin
  Close(m_TextFile);
end;

end.
