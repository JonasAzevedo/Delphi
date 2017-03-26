Skin QuantumGrid5

Vclskin skin cxgrid using cxgrid's styles. all procedure in SkinEQGrid.pas.

Scrollbar of QuantumGrid5 is owner-draw,  it need modify QuantumGrid5 source code to skin them.
Vclskin provide the modified code fro register user.

1. add 'SkinEQGrid.pas' into your project.
2. call 'InitStyle' in FormCreate event.
3. call 'doskinchanged' in TSkinData.onskinchanged event;
4. call 'doskincontrol' in TSkinData.OnSkinControl event;




procedure TUnboundSimpleDemoMainForm.FormCreate(Sender: TObject);
begin
  .......
  InitStyle(SkinData1);
end;

procedure TUnboundSimpleDemoMainForm.SkinData1SkinControl(
  Sender: TComponent; SkinData: TSkinData; Form, Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);
begin
    doskincontrol(sender,skindata,form,control,controlclass,skinnedcontrol);
end;

procedure TUnboundSimpleDemoMainForm.SkinData1SkinChanged(Sender: TObject);
begin
    doskinchanged(sender);
end;
