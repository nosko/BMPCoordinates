object fMain: TfMain
  Left = 0
  Top = 0
  Width = 935
  Height = 743
  HorzScrollBar.Style = ssFlat
  VertScrollBar.Style = ssFlat
  AutoScroll = True
  Caption = 'BMPCoordinates'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 62
    Top = 30
    Width = 31
    Height = 13
    Caption = 'Mierka'
  end
  object Label2: TLabel
    Left = 62
    Top = 42
    Width = 34
    Height = 13
    Caption = 'pixelov'
  end
  object Label3: TLabel
    Left = 395
    Top = 32
    Width = 169
    Height = 13
    Caption = 'Left mouse buttons - dynamic input'
  end
  object from: TLabel
    Left = 607
    Top = 12
    Width = 22
    Height = 13
    Caption = 'from'
  end
  object Label4: TLabel
    Left = 698
    Top = 12
    Width = 10
    Height = 13
    Caption = 'to'
  end
  object bLoad: TButton
    Left = 8
    Top = 0
    Width = 73
    Height = 28
    Caption = 'Load picture'
    TabOrder = 0
    OnClick = bLoadClick
  end
  object bClose: TButton
    Left = 281
    Top = 0
    Width = 80
    Height = 28
    Caption = 'End'
    TabOrder = 1
    OnClick = bCloseClick
  end
  object fitPx: TEdit
    Left = 12
    Top = 34
    Width = 44
    Height = 21
    Alignment = taCenter
    TabOrder = 2
    Text = '10'
    OnChange = fitPxChange
  end
  object fitReal: TEdit
    Left = 95
    Top = 34
    Width = 45
    Height = 21
    Alignment = taCenter
    TabOrder = 3
    Text = '1'
    OnChange = fitRealChange
  end
  object Button1: TButton
    Left = 87
    Top = 0
    Width = 90
    Height = 28
    Caption = 'Click window'
    TabOrder = 4
    OnClick = Button1Click
  end
  object cbUnit: TComboBox
    Left = 146
    Top = 34
    Width = 56
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = 'mm'
    OnChange = cbUnitChange
    Items.Strings = (
      'mm'
      'cm'
      'm')
  end
  object Button2: TButton
    Left = 392
    Top = 0
    Width = 209
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Spine model'
    TabOrder = 6
    OnClick = SpineModelClick
  end
  object Img: TImage32
    Left = 8
    Top = 81
    Width = 4000
    Height = 5000
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 7
    OnMouseDown = ImgMouseDown
    OnMouseMove = ImgMouseMove
    OnMouseUp = ImgMouseUp
  end
  object Button4: TButton
    Left = 183
    Top = 0
    Width = 92
    Height = 28
    Caption = 'Vertebra window'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Vstup_a_: TButton
    Left = 535
    Top = 49
    Width = 66
    Height = 25
    Caption = 'a'
    TabOrder = 9
    OnClick = Vstup_a_Click
  end
  object Vstup_b_: TButton
    Left = 463
    Top = 49
    Width = 66
    Height = 25
    Caption = 'b'
    TabOrder = 10
    OnClick = Vstup_b_Click
  end
  object Vstup_c_: TButton
    Left = 392
    Top = 49
    Width = 65
    Height = 25
    Caption = 'c'
    TabOrder = 11
    OnClick = Vstup_c_Click
  end
  object Spine_preview: TCheckBox
    Left = 112
    Top = 57
    Width = 193
    Height = 17
    Caption = 'Spine preview on right mouse click'
    TabOrder = 12
  end
  object Immediate_action: TCheckBox
    Left = 9
    Top = 57
    Width = 97
    Height = 17
    Caption = 'Immediate action'
    TabOrder = 13
  end
  object Zuzenie: TButton
    Left = 607
    Top = 49
    Width = 65
    Height = 25
    Caption = 'D'
    Font.Charset = SYMBOL_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Symbol'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnClick = ZuzenieClick
  end
  object All_in_one: TButton
    Left = 688
    Top = 48
    Width = 75
    Height = 25
    Caption = 'All in one'
    TabOrder = 15
    OnClick = All_in_oneClick
  end
  object FromEdit: TEdit
    Left = 632
    Top = 8
    Width = 49
    Height = 21
    TabOrder = 16
    Text = 'FromEdit'
    OnChange = FromEditChange
  end
  object ToEdit: TEdit
    Left = 712
    Top = 8
    Width = 51
    Height = 21
    TabOrder = 17
    Text = 'ToEdit'
    OnChange = ToEditChange
  end
  object PopisPrace: TEdit
    Left = 312
    Top = 32
    Width = 74
    Height = 43
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
    Text = 'PopisPrace'
  end
  object Open: TOpenDialog
    Left = 424
    Top = 376
  end
end
