unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ShellCtrls;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    edtFTPFileURL: TEdit;
    Label1: TLabel;
    btnAnalyzeFTPUrl: TButton;
    memAnalyzeFTPUrl: TMemo;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    edtDownloadURL: TEdit;
    Button1: TButton;
    Label3: TLabel;
    edtLocalFileName: TEdit;
    slvDownload: TShellListView;
    Button2: TButton;
    Label4: TLabel;
    edtFTPUserName: TEdit;
    Label5: TLabel;
    edtFTPPassword: TEdit;
    procedure btnAnalyzeFTPUrlClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses jyURLFunc, jyDownloadFTPFile;

{$R *.dfm}

procedure TfrmMain.btnAnalyzeFTPUrlClick(Sender: TObject);
var
  AUser, APwd, ADomain: string;
  APort: integer;
  ADir, AFile: string;
begin
  AnalyzeFTPUrl(edtFTPFileUrl.Text, AUser, APwd, ADomain, APort, ADir, AFile);
  memAnalyzeFTPUrl.Clear;
  memAnalyzeFTPUrl.Lines.Add(format('URL:    [%s]', [edtFTPFileUrl.Text]));
  memAnalyzeFTPUrl.Lines.Add(format('Domain: [%s]', [ADomain]));
  memAnalyzeFTPUrl.Lines.Add(format('Port:   [%d]', [APort]));
  memAnalyzeFTPUrl.Lines.Add(format('User:   [%s]', [AUser]));
  memAnalyzeFTPUrl.Lines.Add(format('Pwd:    [%s]', [APwd]));
  memAnalyzeFTPUrl.Lines.Add(format('Dir:    [%s]', [ADir]));
  memAnalyzeFTPUrl.Lines.Add(format('File:   [%s]', [AFile]));
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  strPath: string;
begin
  strPath := ExtractFilePath(edtLocalFileName.Text);
  slvDownload.Root := strPath;
  slvDownload.Refresh;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if DownloadAFile(edtDownloadURL.Text, edtFTPUserName.Text, edtFTPPassword.Text, edtLocalFileName.Text, true) then
    showmessage('Success. ^_^')
  else
    showmessage('Fail. :(');
end;

end.


