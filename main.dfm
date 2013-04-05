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
    Left = 647
    Top = 0
    Width = 31
    Height = 13
    Caption = 'Mierka'
  end
  object Label2: TLabel
    Left = 650
    Top = 19
    Width = 34
    Height = 13
    Caption = 'pixelov'
  end
  object bLoad: TButton
    Left = 8
    Top = 8
    Width = 73
    Height = 28
    Caption = 'Load picture'
    TabOrder = 0
    OnClick = bLoadClick
  end
  object bClose: TButton
    Left = 518
    Top = 8
    Width = 75
    Height = 28
    Caption = 'End'
    TabOrder = 1
    OnClick = bCloseClick
  end
  object fitPx: TEdit
    Left = 599
    Top = 13
    Width = 44
    Height = 21
    Alignment = taCenter
    TabOrder = 2
    Text = '10'
    OnChange = fitPxChange
  end
  object fitReal: TEdit
    Left = 682
    Top = 13
    Width = 45
    Height = 21
    Alignment = taCenter
    TabOrder = 3
    Text = '1'
    OnChange = fitRealChange
  end
  object Button1: TButton
    Left = 87
    Top = 8
    Width = 104
    Height = 28
    Caption = 'Click coordinates'
    TabOrder = 4
    OnClick = Button1Click
  end
  object cbUnit: TComboBox
    Left = 733
    Top = 13
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
    Left = 405
    Top = 7
    Width = 94
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Spine model'
    TabOrder = 7
    OnClick = KresliStavce
  end
  object Button3: TButton
    Left = 310
    Top = 7
    Width = 91
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Origin'
    TabOrder = 6
    OnClick = IMGCSlateral
  end
  object Img: TImage32
    Left = 8
    Top = 80
    Width = 886
    Height = 633
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 8
    OnMouseDown = ImgMouseDown
    OnMouseMove = ImgMouseMove
    OnMouseUp = ImgMouseUp
  end
  object Button4: TButton
    Left = 197
    Top = 8
    Width = 108
    Height = 28
    Caption = 'Spine data'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Vstup_a_: TButton
    Left = 8
    Top = 40
    Width = 73
    Height = 25
    Caption = 'a'
    TabOrder = 10
    OnClick = Vstup_a_Click
  end
  object Vstup_b_: TButton
    Left = 112
    Top = 40
    Width = 65
    Height = 25
    Caption = 'b'
    TabOrder = 11
    OnClick = Vstup_b_Click
  end
  object Vstup_c_: TButton
    Left = 200
    Top = 40
    Width = 65
    Height = 25
    Caption = 'c'
    TabOrder = 12
    OnClick = Vstup_c_Click
  end
  object Open: TOpenDialog
    Left = 424
    Top = 376
  end
end
