program asg50;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  AdvGrid;

var
  asg: TAdvStringGrid;
  c,err: Integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }

  if ParamCount <> 3 then
    writeln('Use : ASG50 "Sort column" "Input CSV-filename" "Output HTML-filename"')
  else
  begin
    val(paramstr(1),c,err);

    if err= 0 then
    begin

      asg := TAdvStringGrid.Create(nil);

      asg.SaveFixedCells := False;
      asg.LoadFromCSV(paramstr(2));
      asg.SortSettings.AutoFormat := False;
      asg.SortSettings.Column := c;

      asg.QuickSort(c,1,asg.RowCount - 1);

      asg.SaveToHTML(paramstr(3));

      asg.Free;
    end
    else
    begin
      writeln('Use : ASG50 "SortColumn" "Input CSV-filename" "Output CSV-filename"');
      writeln('with SorColumn valid zero based column index');
    end;

  end;


end.
