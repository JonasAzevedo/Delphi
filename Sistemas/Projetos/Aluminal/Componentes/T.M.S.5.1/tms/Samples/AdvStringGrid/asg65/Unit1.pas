{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, AdvGridCSVPager, StdCtrls;

type
  TForm1 = class(TForm)
    AdvGridCSVPager1: TAdvGridCSVPager;
    AdvStringGrid1: TAdvStringGrid;
    btnOpen: TButton;
    btnFirst: TButton;
    btnPrev: TButton;
    btnNext: TButton;
    btnLast: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    dlgOpen: TOpenDialog;
    procedure btnOpenClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateButtons;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  if AdvGridCSVPager1.IsOpen then
  begin
    advgridcsvpager1.Close;
    btnOpen.Caption := 'Open';
    advstringgrid1.Clear;
  end
  else
  begin
    if dlgOpen.Execute then
    begin
      advgridcsvpager1.FileName := dlgOpen.Filename;
      advgridcsvpager1.Open;
      btnOpen.Caption := 'Close';
    end;
  end;
  UpdateButtons;
end;

procedure TForm1.btnFirstClick(Sender: TObject);
begin
  advgridcsvpager1.First;
  UpdateButtons;
end;

procedure TForm1.btnPrevClick(Sender: TObject);
begin
  advgridcsvpager1.Prev;
  UpdateButtons;
end;

procedure TForm1.btnNextClick(Sender: TObject);
begin
  advgridcsvpager1.Next;
  UpdateButtons;
end;

procedure TForm1.btnLastClick(Sender: TObject);
begin
  advgridcsvpager1.Last;
  UpdateButtons;
end;

procedure TForm1.UpdateButtons;
begin
  btnFirst.Enabled := AdvGridCSVPager1.IsOpen and not AdvGridCSVPager1.BOF;
  btnPrev.Enabled := AdvGridCSVPager1.IsOpen and not AdvGridCSVPager1.BOF;
  btnNext.Enabled := AdvGridCSVPager1.IsOpen and not AdvGridCSVPager1.EOF;
  btnLast.Enabled := AdvGridCSVPager1.IsOpen and not AdvGridCSVPager1.EOF;
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  UpdateButtons;
  AdvStringGrid1.SaveFixedCells := false;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  AdvGridCSVPager1.PageSize := strtoint(combobox1.Items[Combobox1.ItemIndex]);
  UpdateButtons;
end;

end.
