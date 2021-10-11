object Form1: TForm1
  Left = 455
  Top = 108
  Width = 800
  Height = 572
  Caption = 'DC++ Chat'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    000000000000000AAAAAAAAAAAAACCCCCCCCCCC00FFF000AAAAAAAAAAAAACCCC
    CCCCCCC00FFFF00AAAAAAAAAAAAACCCCCCCCCCC00FFFF00AAAAAAAAAAAAACCCC
    CCCCCCC00FFFF00AAAAAAAAAAAAACCCCCCCCCCC00FFFF00AAAAAAAAAAAAACCCC
    CCCCCCC00FFFF00AAAAAAAAAAAAACCCCCCCCCCC00FFFF00AAAAAAAAAAAAACCCC
    CCCCCCC00FFFF00AAAAAAAAAAAAACCCCCCCCCCC00FFFF00AAAAAAAAAAAAACCCC
    CCCCCCC00FFFF00AAAAAAAAAAAAACCCCCCCCCCC00FFFF00AAAAAAAAAAAAA0000
    000000000FFFF0000000000000000000000000000FFFF000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000
    000000000FFFF0000000000000000000000000000FFFF0000000000000009999
    999999900FFFF00BBBBBBBBBBBBB9999999999900FFFF00BBBBBBBBBBBBB9999
    999999900FFFF00BBBBBBBBBBBBB9999999999900FFFF00BBBBBBBBBBBBB9999
    999999900FFFF00BBBBBBBBBBBBB9999999999900FFFF00BBBBBBBBBBBBB9999
    999999900FFFF00BBBBBBBBBBBBB9999999999900FFFF00BBBBBBBBBBBBB9999
    999999900FFFF00BBBBBBBBBBBBB9999999999900FFFF00BBBBBBBBBBBBB9999
    999999900FFFF00BBBBBBBBBBBBB99999999999000FFF00BBBBBBBBBBBBBFFFF
    E0000018E0000018600000186000001860000018600000186000001860000018
    6000001860000018600000186000FFF87FFFFFF87FFF00000000000000000000
    0000C0000001FFF87FFFFFF87FFF001860000018600000186000001860000018
    6000001860000018600000186000001860000018600000186000001C6000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 648
    Top = 37
    Width = 6
    Height = 468
    Cursor = crHSplit
    Align = alRight
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 526
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 505
    Width = 792
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Edit1: TEdit
      Left = 1
      Top = 1
      Width = 439
      Height = 21
      Color = clSilver
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
  end
  object Memo2: TMemo
    Left = 610
    Top = 64
    Width = 67
    Height = 39
    Lines.Strings = (
      'Memo2')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 37
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 11
      Width = 36
      Height = 13
      Caption = 'DC hub'
    end
    object Label2: TLabel
      Left = 187
      Top = 11
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label3: TLabel
      Left = 295
      Top = 11
      Width = 22
      Height = 13
      Caption = 'Nick'
    end
    object Label4: TLabel
      Left = 459
      Top = 11
      Width = 23
      Height = 13
      Caption = 'Pass'
    end
    object Edit2: TEdit
      Left = 49
      Top = 7
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 211
      Top = 7
      Width = 40
      Height = 21
      TabOrder = 1
    end
    object Edit4: TEdit
      Left = 323
      Top = 7
      Width = 121
      Height = 21
      TabOrder = 2
    end
    object Edit5: TEdit
      Left = 489
      Top = 7
      Width = 121
      Height = 21
      PasswordChar = 'x'
      TabOrder = 3
    end
    object Button1: TButton
      Left = 678
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 4
      OnClick = Button1Click
    end
  end
  object Memo1: TRichEdit
    Left = 0
    Top = 37
    Width = 648
    Height = 468
    Align = alClient
    Color = clSilver
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PlainText = True
    PopupMenu = PopupMenu1
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object ListBox1: TListBox
    Left = 654
    Top = 37
    Width = 138
    Height = 468
    Align = alRight
    Color = clSilver
    ItemHeight = 13
    Sorted = True
    TabOrder = 5
    OnDblClick = ListBox1DblClick
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    Left = 738
    Top = 4
  end
  object PopupMenu1: TPopupMenu
    Left = 736
    Top = 34
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object ClearChat1: TMenuItem
      Caption = 'Clear Chat'
      OnClick = ClearChat1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 700
    Top = 38
  end
end
