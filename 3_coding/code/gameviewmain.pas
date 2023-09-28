{ Main view, where most of the application logic takes place.

  Feel free to use this code as a starting point for your own projects.
  This template code is in public domain, unlike most other CGE code which
  is covered by BSD or LGPL (see https://castle-engine.io/license). }
unit GameViewMain;

interface

uses Classes,
  CastleVectors, CastleComponentSerialize, CastleSoundEngine,
  CastleUIControls, CastleControls, CastleKeysMouse,
  CastleScene, CastleViewport, CastleTransform;

type
  { Main view, where most of the application logic takes place. }
  TViewMain = class(TCastleView)
  published
    { Components designed using CGE editor.
      These fields will be automatically initialized at Start. }
    LabelFps: TCastleLabel;
    Button1, ButtonMove, ButtonLoadBunny: TCastleButton;
    SoundZap: TCastleSound;
    Scene1: TCastleScene;
    Viewport1: TCastleViewport;
  private
    procedure ClickButton1(Sender: TObject);
    procedure ClickMove(Sender: TObject);
    procedure ClickBunny(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; override;
    procedure Update(const SecondsPassed: Single; var HandleInput: Boolean); override;
    function Press(const Event: TInputPressRelease): Boolean; override;
  end;

var
  ViewMain: TViewMain;

implementation

uses SysUtils, CastleLog;

{ TViewMain ----------------------------------------------------------------- }

constructor TViewMain.Create(AOwner: TComponent);
begin
  inherited;
  DesignUrl := 'castle-data:/gameviewmain.castle-user-interface';
end;

procedure TViewMain.ClickButton1(Sender: TObject);
begin
  WritelnLog('button!');
  SoundEngine.Play(SoundZap);
end;

procedure TViewMain.Start;
begin
  inherited;
  Button1.OnClick := ClickButton1;
  ButtonMove.OnClick := ClickMove;
  ButtonLoadBunny.OnClick := ClickBunny;
end;

procedure TViewMain.Update(const SecondsPassed: Single; var HandleInput: Boolean);
begin
  inherited;
  { This virtual method is executed every frame (many times per second). }
  Assert(LabelFps <> nil, 'If you remove LabelFps from the design, remember to remove also the assignment "LabelFps.Caption := ..." from code');
  LabelFps.Caption := 'FPS: ' + Container.Fps.ToString;
end;

function TViewMain.Press(const Event: TInputPressRelease): Boolean;
var
  Body: TCastleRigidBody;
  NewTransform: TCastleTransform;
begin
  Result := inherited;
  if Result then Exit; // allow the ancestor to handle keys

  { This virtual method is executed when user presses
    a key, a mouse button, or touches a touch-screen.

    Note that each UI control has also events like OnPress and OnClick.
    These events can be used to handle the "press", if it should do something
    specific when used in that UI control.
    The TViewMain.Press method should be used to handle keys
    not handled in children controls.
  }

  // Use this to handle keys:
  if Event.IsKey(keyX) then
  begin
    if Viewport1.TransformUnderMouse <> nil then
    begin
      Body := Viewport1.TransformUnderMouse.FindBehavior(TCastleRigidBody) as TCastleRigidBody;
      if Body <> nil then
        Body.ApplyImpulse(
          Vector3(0, 10, 0),
          Viewport1.TransformUnderMouse.Translation
        );
    end;

    Exit(true); // key was handled
  end;

  if Event.IsKey(keyZ) then
  begin
   NewTransform := TransformLoad('castle-data:/my_box.castle-transform', FreeAtStop);
   NewTransform.Translation := Viewport1.Camera.Translation +
     Viewport1.Camera.Direction * 3;
   NewTransform.Direction := Viewport1.Camera.Direction;
   // could be done cleaner by loading NewTransform in new owner and looking for name
   Body := NewTransform.Items[0].FindBehavior(TCastleRigidBody) as TCastleRigidBody;
   Viewport1.Items.Add(NewTransform);
   Body.ApplyImpulse(
     Viewport1.Camera.Direction * 0.5,
     Viewport1.Camera.Translation);
  end;
end;

procedure TViewMain.ClickMove(Sender: TObject);
begin
  Scene1.Translation := Scene1.Translation + Vector3(0, 1, 0);
end;

procedure TViewMain.ClickBunny(Sender: TObject);
begin
  Scene1.Url := 'castle-data:/Bunny.gltf';
end;

end.
