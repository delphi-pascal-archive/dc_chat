unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Winsock, ScktComp, ComCtrls, ExtCtrls,ShellApi, Menus,
  Clipbrd,DateUtils;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Edit1: TEdit;
    Memo2: TMemo;
    Panel2: TPanel;
    Edit2: TEdit;
    Label1: TLabel;
    Edit3: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Label3: TLabel;
    Edit5: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Memo1: TRichEdit;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    ClearChat1: TMenuItem;
    Timer1: TTimer;
    ListBox1: TListBox;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormResize(Sender: TObject);
    procedure ClearChat1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Konekted:boolean;
  FileShareSize:string;
  FileShareSizeInt:int64;
  FileListLen:dword;
  FileListLenText:string;
  Param1,Param2,Param3:string;
  Konektvane,Income:boolean;
implementation

{$R *.dfm}
//============================================================
procedure ObrabotkaKomandi(TTTX:string);forward;
procedure ObrabotkaKomandi22(TTTX:string);forward;
//============================================================
procedure GenerateFileList;
Label 11;
var XX,FileCount:integer;
   YY:int64;
begin
11:
FileShareSizeInt:=Random($FF)+1;
FileShareSizeInt:=FileShareSizeInt * 256;
FileShareSizeInt:=FileShareSizeInt+Random($FF)+1;
FileShareSizeInt:=FileShareSizeInt * 256;
FileShareSizeInt:=FileShareSizeInt+Random($FF)+1;
FileShareSizeInt:=FileShareSizeInt * 256;
FileShareSizeInt:=FileShareSizeInt+Random($F)+1;
FileShareSizeInt:=FileShareSizeInt * 256;

FileShareSize:=IntToStr(FileShareSizeInt);
YY:= FileShareSizeInt div 1073741824;
IF YY < 333 Then Goto 11;

FileListLen:=Random(100000) + 200000;
FileListLenText:=IntToStr(FileListLen);

end;
//============================================================
function GetIPFromHost(const HostName: string): string;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  i: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  phe := GetHostByName(PChar(HostName));
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pPtr^[i] <> nil do
  begin
    Result := inet_ntoa(pptr^[i]^);
    Inc(i);
  end;
  WSACleanup;
end;
//============================================================
function LockToKey (StrLock : string) : string;
     
  // The follow function converts "1" (byte) to "001" (string), "10" to "010" and so on
  function ByteToThreeCharStr (Value : byte) : string;
  begin
     if value < 10 then
       result := '00'+inttostr(value)
     else
    if value < 100 then
      result := '0'+inttostr(value)
    else
      result := inttostr(value);
  end;

var i : byte;
    Temp : string;
    TempChar : byte;

begin
  result := '';
  if length (StrLock) < 3 then 
    begin
      result := 'BROKENCLIENT';
      setlength (result,length(strlock));
      exit;
    end;

  // First char
  temp := chr (ord (StrLock[1]) xor ord (StrLock[length(StrLock)])
    xor ord (StrLock[length(strLock)-1]) xor 5);

    //asm
      //ror temp[1], 4 // <- Nibble swap! We swap the last four bits with the first four: 00101111 -> 11110010
    //end;

  for i := 2 to length (StrLock) do
    begin
    temp := temp + chr (ord(StrLock[i]) xor ord (StrLock[i-1]));
    //asm
      //ror temp[i], 4 // <- Nibble swap! We swap the last four bits with the first four: 00101111 -> 11110010
    //end;
    end;
    
  result :='';
  for i := 1 to length (temp) do
  begin
    TempChar := ord (temp[i]);
    
    // I now used assembler. In the visual basic code the same was done with ugly math
    asm
      ror TempChar, 4 // <- Nibble swap! We swap the last four bits with the first four: 00101111 -> 11110010
    end;

    // Some chars need to be replaced with a string like "/%DCN005%/"
    If (TempChar = 0) or (TempChar = 5) or (TempChar = 36) or (TempChar = 96)
      or (TempChar = 124) or (TempChar = 126)
    then
      result := result + '/%DCN' + ByteToThreeCharStr(TempChar) + '%/'
    else
      result := result + chr (TempChar);
  end;
end;
//============================================================


procedure TForm1.FormCreate(Sender: TObject);
begin
  ThousandSeparator:=' ';
  DecimalSeparator:='.';
  DateSeparator:='-';
  ShortDateFormat:='dd-MM-yyyy';
  LongDateFormat:='dd MMMM yyyy';
  TimeSeparator:=':';
  ShortTimeFormat:='HH:mm:ss';
  LongTimeFormat:='HH:mm';
  //FormatTD:='HH:mm:ss    dd/MM/yyyy';
  
end;

procedure TForm1.FormShow(Sender: TObject);
begin
Konektvane:=False;
Income:=False;

 If FileExists('cfg.txt') Then
 begin
 Form1.Memo2.Clear;
 Form1.Memo2.Lines.LoadFromFile('cfg.txt');
 IF Form1.Memo2.Text<>'' Then
   begin
   Form1.Edit2.Text:=Form1.Memo2.Lines.Strings[0];
   Form1.Edit3.Text:=Form1.Memo2.Lines.Strings[1];
   Form1.Edit4.Text:=Form1.Memo2.Lines.Strings[2];
   Form1.Edit5.Text:=Form1.Memo2.Lines.Strings[3];
   end;
 end;
 GenerateFileList;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
ClientSocket1.Active := false;
Konekted:=false;

 Form1.Memo2.Clear;
 Form1.Memo2.Lines.Add(Form1.Edit2.Text);
 Form1.Memo2.Lines.Add(Form1.Edit3.Text);
 Form1.Memo2.Lines.Add(Form1.Edit4.Text);
 Form1.Memo2.Lines.Add(Form1.Edit5.Text);
 Form1.Memo2.Lines.SaveToFile('cfg.txt');

 //Application.Terminate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

IF Konektvane=False Then
  begin
  Konektvane:=True;
  Form1.Button1.Caption:='Disconnect';
  Form1.Timer1.Enabled:=True;
  Form1.ListBox1.Clear;
  ClientSocket1.Port :=  strtoint(Form1.Edit3.Text);
  ClientSocket1.Host:=GetIPFromHost(Form1.Edit2.Text);
  ClientSocket1.Active :=  true;
  Form1.Memo1.Clear;
  Konekted:=false;
  Income:=False;
  end Else begin
  Konektvane:=False;
  Form1.Button1.Caption:='Connect';
  Form1.Timer1.Enabled:=False;
  ClientSocket1.Active :=  false;
  Konekted:=false;
  Income:=False;
  end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 IF Ord(Key)=$0D Then
   if ClientSocket1.Active then
    begin
    ClientSocket1.Socket.SendText('<'+Form1.Edit4.Text+'> '+Form1.Edit1.Text+'|');
    //Form1.Memo1.Lines.Add(Form1.Edit4.Text+' : '+ Form1.Edit1.Text);
    Form1.Edit1.Text:='';
    end;

end;


procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Form1.Memo1.Color:=clWhite;
 Form1.ListBox1.Color:=clWhite;
 //Form1.Edit1.Color:=clWhite;
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
 Income:=False;
 Konekted:=false;
 Form1.Memo1.Color:=clSilver;
 Form1.Edit1.Color:=clSilver;
 Form1.ListBox1.Color:=clSilver;
end;
//============================================================
procedure SendMyInfo;
var SS:string;
begin
      SS:='$Version 1,0091|$MyINFO $ALL '+Form1.Edit4.Text+' <++ V:2.42,M:P,H:1/0/0,S:8>$ $100 1$$'+FileShareSize+'$|';
      Form1.ClientSocket1.Socket.SendText(SS);
      //Form1.Memo1.Lines.Add(SS);
end;
//============================================================
procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);

Label 11,22,33,44,89,000,5678;
var TTT,SS1,SS2,SS3,SS4,Key,Key2,SS,KomandSTR:string;
  II,LL,XX,N1,N2,Nink,PP,KKKK:integer;
  BB:byte;
  
begin

 TTT:='';
 TTT:=Socket.ReceiveText;
 ObrabotkaKomandi(TTT);

end;
//============================================================
procedure GetParameters(KKK:string);
var XX,LL:integer;
label 11,22,33,44;
begin
 LL:=Length(KKK);
 Param1:='';
 Param2:='';
 Param3:='';
 IF LL < 2 Then Exit;
 XX:=1;
11:
 IF KKK[XX]=' ' Then Goto 22;
 IF KKK[XX]='|' Then Goto 22;
 Param1:=Param1 + KKK[XX];
 inc(XX);
IF XX <= LL Then Goto 11;

22:
 inc(XX);
 IF XX > LL Then Goto 44;
 IF KKK[XX]=' ' Then Goto 33;
 IF KKK[XX]='|' Then Goto 33;
 Param2:=Param2 + KKK[XX];

IF XX <= LL Then Goto 22;

33:

 inc(XX);
 IF XX > LL Then Goto 44;
 IF KKK[XX]=' ' Then Goto 44;
 IF KKK[XX]='|' Then Goto 44;
 Param3:=Param3 + KKK[XX];

IF XX <= LL Then Goto 33;

44:

end;
//============================================================
procedure Ednakvi;
var SS1,SS2:string; XX,NN,LL:integer;
label 11;
begin
XX:=0;
11:
 LL:=Form1.ListBox1.Items.Count;
 IF LL < 2 Then Exit;

 SS1:=Form1.ListBox1.Items.Strings[XX];
 SS2:=Form1.ListBox1.Items.Strings[XX+1];
 IF SS1=SS2 Then Form1.ListBox1.Items.Delete(XX);
 inc(XX);
IF XX < LL-2 Then Goto 11;

end;
//============================================================
procedure ObrabotkaKomandi(TTTX:string);
var KomandSTR:string; I,LL,NN:integer; TME:TTime;
begin
 KomandSTR:='';
 LL:=Length(TTTX);
 i:=0;

 //Form1.Memo1.Lines.Add(TTTX);

  While i < LL do
    begin
    inc(i);
    IF TTTX[i]<>'|' Then
      begin
      KomandSTR:=KomandSTR+TTTX[i];
      end Else begin
      //Form1.Memo1.Lines.Add(KomandSTR);
      IF TTTX[i]='|' Then
        begin
        IF Length(KomandSTR)>1 Then
        IF KomandSTR[1]='$' Then
          begin
          ObrabotkaKomandi22(KomandSTR);
          end;
        IF Length(KomandSTR)>1 Then
        IF (KomandSTR[1]='<')or(KomandSTR[1]='*') Then
          begin
          Form1.Memo1.Lines.Add(TimeToStr(Now)+KomandSTR);
          NN:=Ansipos(Form1.Edit4.Text,KomandSTR);
          IF NN>2 Then windows.FlashWindow(Application.Handle,True);
          end;
        KomandSTR:='';
        end;
      end;
    end;
  //---------------------------------------------
end;
//============================================================
procedure ObrabotkaKomandi22(TTTX:string);
var SS1,SS2,SS3,SS4,SS:string; i,LL,NN:integer;
begin

GetParameters(TTTX);

//Form1.Memo1.Lines.Add(Param1);

  //---------------------------------------------
   IF Param1='$Lock' Then
    begin
    SS:=LockToKey(Param2);
    Form1.ClientSocket1.Socket.SendText('$Key '+SS+'|$ValidateNick '+Form1.Edit4.Text+'|');
    //Form1.Memo1.Lines.Add(SS);
    end;

  //---------------------------------------------
  IF Param1='$GetPass' Then
    begin
      SS:='$MyPass '+Form1.Edit5.Text+'|';
      Form1.ClientSocket1.Socket.SendText(SS);
      //Form1.Memo1.Lines.Add(SS);
    end;
  //---------------------------------------------
  IF Param1='$LogedIn' Then
    begin
      Form1.Edit1.Color:=clWhite;
    end;
  //---------------------------------------------
  IF Param1='$ValidateDenide' Then
    begin
    //ClientSocket1.Active :=  false;
    end;
  //---------------------------------------------
  IF Param1='$BadPass' Then
    begin
      //ClientSocket1.Active :=  false;
      Form1.Memo1.Lines.Add(Param1);
    end;
  //---------------------------------------------
  IF Param1='$Hello' Then
    begin
      SendMyInfo;
      Form1.Edit1.Color:=clWhite;
      Konekted:=true;
    end;
  //---------------------------------------------
  IF Param1='$HubName' Then
    begin
    //SendMyInfo;
    Konekted:=true;
    end;
  //---------------------------------------------
  IF Param1='$GetListLen' Then
    begin
      Form1.ClientSocket1.Socket.SendText('$ListLen '+FileListLenText+'|');
    end;
  //---------------------------------------------
  IF Param1='$To:' Then
    begin
    SS:=TTTX;
    IF SS[LL]='|' Then SetLength(SS,LL-1);
    Form1.Memo1.Lines.Add('--- Private --- '+SS);
    end;
  //---------------------------------------------
  //---------------------------------------------
  IF (Param1='$OpList')or(Param1='$UserCommand') Then
    begin
    Income:=True;
    end;
  //---------------------------------------------
  IF Income=True Then
  IF Param1='$MyINFO' Then
    begin
    Ednakvi;

    //Form1.Memo1.Lines.Add('Enter '+Param3);
    end;
  //---------------------------------------------
  IF Param1='$MyINFO' Then
    begin
    

    Form1.ListBox1.Items.Add(Param3);
    
    NN:=Form1.ListBox1.Items.Count;
    Form1.StatusBar1.Panels.Items[0].Text:=inttostr(NN)+' Users';
    end;
  //---------------------------------------------
  //---------------------------------------------
  IF Param1='$Quit' Then
    begin
    NN:=Form1.ListBox1.Items.IndexOf(Param2);
    Form1.ListBox1.Items.Delete(NN);

    NN:=Form1.ListBox1.Items.Count;
    Form1.StatusBar1.Panels.Items[0].Text:=inttostr(NN)+' Users';
    //Form1.Memo1.Lines.Add('Quit '+Param2);

    Ednakvi;
    end;
  //---------------------------------------------
  {IF (Param1='$RevConnectToMe')or(Param1='$ConnectToMe') Then
    begin
    //ClientSocket1.Socket.SendText('$Error :)|');
    //ClientSocket1.Socket.SendText('$Canceled|');
    //ClientSocket1.Socket.SendText('$RevConnectToMe '+Form1.Edit4.Text+' '+SS2+'|');
    Form1.Memo1.Lines.Add('--- '+SS2 + ' GetFileList ---');
    end; }
  //---------------------------------------------
end;
//============================================================
procedure TForm1.FormResize(Sender: TObject);
begin
 Form1.Edit1.Width:=Form1.Panel1.Width-1;
end;

procedure TForm1.ClearChat1Click(Sender: TObject);
begin
 Form1.Memo1.Clear;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
Form1.Memo1.CopyToClipboard;
//ClipBoardAsText;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
IF Konektvane=False Then Exit;
IF Konekted=True Then Exit;

  ClientSocket1.Port :=  strtoint(Form1.Edit3.Text);
  ClientSocket1.Host:=GetIPFromHost(Form1.Edit2.Text);
  ClientSocket1.Active :=  true;
  Konekted:=false;
  Form1.ListBox1.Clear;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
var SS:string; NN:integer;
begin

  NN:=Form1.ListBox1.ItemIndex;
  SS:=Form1.ListBox1.Items.Strings[NN];
  Form1.Edit1.Text:=SS;
end;

end.
