unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, Fmx.CastleControl,
  CastleViewport;

type
  TForm1 = class(TForm)
    CastleControl1: TCastleControl;
    ButtonBunny: TButton;
    ButtonDino: TButton;
    procedure ButtonBunnyClick(Sender: TObject);
    procedure ButtonDinoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Viewport: TCastleViewport;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses CastleScene, CastleCameras, CastleVectors;

procedure TForm1.ButtonBunnyClick(Sender: TObject);
var
  Scene: TCastleScene;
begin
  Scene := TCastleScene.Create(Self);
  Scene.Cache := true; // makes subsequent loading of the same file fast
  Scene.URL := 'castle-data:/Bunny.gltf';
  Scene.Translation := Vector3(
    Random * 10,
    Random * 10,
    Random * 10);
  Scene.PlayAnimation('Jump', true);
  Viewport.Items.Add(Scene);
end;

procedure TForm1.ButtonDinoClick(Sender: TObject);
var
  Scene: TCastleScene;
begin
  Scene := TCastleScene.Create(Self);
  Scene.Cache := true; // makes subsequent loading of the same file fast
  Scene.URL := 'castle-data:/Dino.gltf';
  Scene.Translation := Vector3(
    Random * 10,
    Random * 10,
    Random * 10);
  Scene.PlayAnimation('Jump', true);
  Viewport.Items.Add(Scene);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Viewport := TCastleViewport.Create(Self);
  CastleControl1.Container.Controls.InsertFront(Viewport);
  Viewport.FullSize := true;
  Viewport.InsertFront(TCastleExamineNavigation.Create(Self));
  // to see scenes randomized above
  Viewport.Camera.SetView(
    Vector3(5, 5, 15),
    Vector3(0, 0, -1),
    Vector3(0, 1, 0)
  );
  // simplest headlight
  Viewport.Camera.Add(TCastleDirectionalLight.Create(Self));
end;

end.
