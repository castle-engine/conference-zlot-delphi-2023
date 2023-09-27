object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 679
  ClientWidth = 970
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object CastleControl1: TCastleControl
    Left = 128
    Top = 88
    Width = 545
    Height = 457
  end
  object ButtonBunny: TButton
    Left = 752
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Bunny'
    TabOrder = 1
    OnClick = ButtonBunnyClick
  end
  object ButtonDino: TButton
    Left = 752
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Dino'
    TabOrder = 2
    OnClick = ButtonDinoClick
  end
end
