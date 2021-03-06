unit jyDownloadFTPFile;

interface

uses Classes;

function DownloadToFile(AURL, AUser, APassword, ALocalFile: string; ACanOverwrite: boolean): boolean;
function UploadFromFile(ALocalFile, AURL, AUser, APassword: string; var AErrorMsg: string): boolean;
function DownloadToStream(AURL, AUser, APassword: string; AStream: TStream): boolean;

implementation

uses SysUtils, IdFTP, IdFTPCommon, jyURLFunc;

function DownloadToFile(AURL, AUser, APassword, ALocalFile: string; ACanOverwrite: boolean): boolean;
var
  idftp: TIdFTP;
  strUser: string;
  strPwd: string;
  strDomain: string;
  iPort: integer;
  strDir: string;
  strFileName: string;
begin
  result := false;

  if not AnalyzeFTPUrl(AURL, strUser, strPwd, strDomain, iPort, strDir, strFileName) then exit;
  if AUser<>'' then
  begin
    strUser := AUser;
    strPwd  := APassword;
  end;
  if strUser = '' then
  begin
    strUser := 'anonymous';
    strPwd  := '@jysoft';
  end;

  idftp := TIdFTP.Create(nil);
  try try
    idftp.TransferType := ftBinary;
    idftp.Passive := true;
    idftp.Host := strDomain;
    idftp.Port := iPort;
    idftp.Username := strUser;
    idftp.Password := strPwd;
    idftp.Connect(True);
    idftp.ChangeDir(strDir);
    idftp.Get(strFileName, ALocalFile, ACanOverwrite);
    result := true;
    idftp.Disconnect;
  finally
    if idftp.Connected then idftp.Disconnect;
    idftp.Free;
  end;
  except
  end;
end;

function UploadFromFile(ALocalFile, AURL, AUser, APassword: string; var AErrorMsg: string): boolean;
var
  idftp: TIdFTP;
  strUser: string;
  strPwd: string;
  strDomain: string;
  iPort: integer;
  strDir: string;
  strFileName: string;
begin
  result := false;
  AErrorMsg := '';

  if not AnalyzeFTPUrl(AURL, strUser, strPwd, strDomain, iPort, strDir, strFileName) then exit;
  if AUser<>'' then
  begin
    strUser := AUser;
    strPwd  := APassword;
  end;
  if strUser = '' then
  begin
    strUser := 'anonymous';
    strPwd  := '@jysoft';
  end;

  idftp := TIdFTP.Create(nil);
  try try
    idftp.TransferType := ftBinary;
    idftp.Passive := true;
    idftp.Host := strDomain;
    idftp.Port := iPort;
    idftp.Username := strUser;
    idftp.Password := strPwd;
    idftp.Connect(True);
    idftp.ChangeDir(strDir);
    idftp.Put(ALocalFile, strFileName);
    result := true;
    idftp.Disconnect;
  finally
    if idftp.Connected then idftp.Disconnect;
    idftp.Free;
  end;
  except
    on e:exception do AErrorMsg := e.message;
  end;
end;

function DownloadToStream(AURL, AUser, APassword: string; AStream: TStream): boolean;
var
  idftp: TIdFTP;
  strUser: string;
  strPwd: string;
  strDomain: string;
  iPort: integer;
  strDir: string;
  strFileName: string;
begin
  result := false;

  if not AnalyzeFTPUrl(AURL, strUser, strPwd, strDomain, iPort, strDir, strFileName) then exit;
  if AUser<>'' then
  begin
    strUser := AUser;
    strPwd  := APassword;
  end;
  if strUser = '' then
  begin
    strUser := 'anonymous';
    strPwd  := '@jysoft';
  end;

  idftp := TIdFTP.Create(nil);
  try try
    idftp.TransferType := ftBinary;
    idftp.Passive := true;
    idftp.Host := strDomain;
    idftp.Port := iPort;
    idftp.Username := strUser;
    idftp.Password := strPwd;
    idftp.Connect(True);
    idftp.ChangeDir(strDir);
    idftp.Get(strFileName, AStream);
    result := true;
    idftp.Disconnect;
  finally
    if idftp.Connected then idftp.Disconnect;
    idftp.Free;
  end;
  except
  end;
end;

end.
