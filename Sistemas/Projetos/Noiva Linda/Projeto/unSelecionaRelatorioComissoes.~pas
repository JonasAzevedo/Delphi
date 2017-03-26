unit unSelecionaRelatorioComissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FMTBcd, RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave,
  DBClient, Provider, DB, SqlExpr, AppEvnts, ComCtrls, StdCtrls, Mask,
  Buttons, ExtCtrls;

type
  TfrmSelecionaRelatorioComissoes = class(TForm)
    pnlVenda: TPanel;
    Label3: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    edFuncionario: TEdit;
    btBtnNova: TBitBtn;
    mEdData1: TMaskEdit;
    btBtnGerar: TBitBtn;
    mEdData2: TMaskEdit;
    btBtnAbreFuncionario: TBitBtn;
    rdBtnComissaoResumo: TRadioButton;
    rdBtnComissaoDetalhado: TRadioButton;
    ckBxLocacoes: TCheckBox;
    ckBxVendas: TCheckBox;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    qryComissoes: TSQLQuery;
    dspComissoes: TDataSetProvider;
    cdsComissoes: TClientDataSet;
    qrySomaLocacoes: TSQLQuery;
    dspSomaLocacoes: TDataSetProvider;
    cdsSomaLocacoes: TClientDataSet;
    cdsComissoesCODIGO: TIntegerField;
    cdsComissoesCOD_FUNCIONARIO: TIntegerField;
    cdsComissoesCOD_LOCACAO: TIntegerField;
    cdsComissoesCOD_VENDA: TIntegerField;
    cdsComissoesVALOR: TFMTBCDField;
    cdsComissoesDATA: TSQLTimeStampField;
    cdsComissoesNOME: TStringField;
    cdsComissoesDATA_INICIO: TSQLTimeStampField;
    cdsComissoesOBSERVACOES: TStringField;
    cdsComissoesVALOR_TOTAL: TFMTBCDField;
    cdsComissoesVALOR_PAGO: TFMTBCDField;
    cdsComissoesValor_Resta: TFMTBCDField;
    qryComissoesCODIGO: TIntegerField;
    qryComissoesCOD_FUNCIONARIO: TIntegerField;
    qryComissoesCOD_LOCACAO: TIntegerField;
    qryComissoesCOD_VENDA: TIntegerField;
    qryComissoesVALOR: TFMTBCDField;
    qryComissoesDATA: TSQLTimeStampField;
    qryComissoesNOME: TStringField;
    qryComissoesDATA_INICIO: TSQLTimeStampField;
    qryComissoesOBSERVACOES: TStringField;
    qryComissoesVALOR_TOTAL: TFMTBCDField;
    qryComissoesVALOR_PAGO: TFMTBCDField;
    qryComissoesValor_Resta: TFMTBCDField;
    cdsSomaLocacoesTotal: TFMTBCDField;
    cdsSomaLocacoesNOME: TStringField;
    qrySomaVendas: TSQLQuery;
    dspSomaVendas: TDataSetProvider;
    cdsSomaVendas: TClientDataSet;
    qrySomaVendasTotal: TFMTBCDField;
    qrySomaVendasNOME: TStringField;
    cdsSomaVendasTotal: TFMTBCDField;
    cdsSomaVendasNOME: TStringField;
    qrySomaLocacoesTotal: TFMTBCDField;
    qrySomaLocacoesNOME: TStringField;
    procedure edFuncionarioEnter(Sender: TObject);
    procedure mEdData1Enter(Sender: TObject);
    procedure mEdData2Enter(Sender: TObject);
    procedure edFuncionarioExit(Sender: TObject);
    procedure mEdData1Exit(Sender: TObject);
    procedure mEdData2Exit(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btBtnNovaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnAbreFuncionarioClick(Sender: TObject);
    procedure btBtnGerarClick(Sender: TObject);
  private
    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
  public
    codFuncionario: Integer; //controle do Funcionário
  end;

var
  frmSelecionaRelatorioComissoes: TfrmSelecionaRelatorioComissoes;

implementation

uses unSelecionaFuncionario, unRelatorioComissoesResumo,
  unVerResumoRelatorioComissoes, Grids;

{$R *.dfm}

(*PROCEDURES DE CONTROLE*)
procedure TfrmSelecionaRelatorioComissoes.limpar();
begin
  Self.codFuncionario := 0;
  rdBtnComissaoResumo.Checked := true;
  rdBtnComissaoDetalhado.Checked := false;
  edFuncionario.Clear;
  ckBxLocacoes.Checked := true;
  ckBxVendas.Checked := true;
  mEdData1.Clear;
  mEdData2.Clear;
end;
(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmSelecionaRelatorioComissoes.edFuncionarioEnter(
  Sender: TObject);
begin
  edFuncionario.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioComissoes.mEdData1Enter(Sender: TObject);
begin
  mEdData1.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioComissoes.mEdData2Enter(Sender: TObject);
begin
  mEdData2.Color := clMoneyGreen;
end;

procedure TfrmSelecionaRelatorioComissoes.edFuncionarioExit(
  Sender: TObject);
begin
  edFuncionario.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioComissoes.mEdData1Exit(Sender: TObject);
begin
  mEdData1.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioComissoes.mEdData2Exit(Sender: TObject);
begin
  mEdData2.Color := clWindow;
end;

procedure TfrmSelecionaRelatorioComissoes.ApplicationEventsHint(
  Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmSelecionaRelatorioComissoes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=27) then
    Self.Close;
end;

procedure TfrmSelecionaRelatorioComissoes.btBtnNovaClick(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioComissoes.FormShow(Sender: TObject);
begin
  Self.limpar();
end;

procedure TfrmSelecionaRelatorioComissoes.btBtnAbreFuncionarioClick(
  Sender: TObject);
begin
  Application.CreateForm(TfrmSelecionaFuncionario,frmSelecionaFuncionario);
  frmSelecionaFuncionario.tela := 'relatorioComissoes';
  frmSelecionaFuncionario.ShowModal;
  frmSelecionaFuncionario.Free;
end;

procedure TfrmSelecionaRelatorioComissoes.btBtnGerarClick(Sender: TObject);
var
  continua: boolean;
  temRelResumo: boolean;
  i: Integer;
  x: Integer;
  achouFunc: boolean;
begin
  i:=1;
  temRelResumo := false;
  continua := true;
  //verificando se pode-se realizar pesquisa
  if ((ckBxLocacoes.Checked=false)and(ckBxVendas.Checked=false))then
    begin
    MessageDlg('Selecione pelo menos um Tipo de Comissão!',mtInformation,[mbOK],0);
    continua := false;
    end;

  if(continua=true)then
    begin
    //detalhado
    if(rdBtnComissaoDetalhado.Checked=true)then
      begin
      qryComissoes.Close;
      qryComissoes.SQL.Clear;
      //locações
      if(ckBxLocacoes.Checked=true)then
        begin
        qryComissoes.SQL.Add('SELECT c.codigo,c.cod_funcionario,c.cod_locacao,c.cod_venda,c.valor,c.data, ');
        qryComissoes.SQL.Add('u.nome, ');
        qryComissoes.SQL.Add('l.data_inicio,l.observacoes,l.valor_total,l.valor_pago,(l.valor_total-l.valor_pago) AS "Valor_Resta" ');
        qryComissoes.SQL.Add('FROM comissao_funcionario c, usuario u, locacao l ');
        qryComissoes.SQL.Add('WHERE c.cod_funcionario=u.codigo ');
        qryComissoes.SQL.Add('AND c.cod_locacao=l.codigo ');
        //funcionário
        if (Self.codFuncionario<>0) then
          begin
          qryComissoes.SQL.Add('AND c.cod_funcionario=:codFunLoc ');
          qryComissoes.ParamByName('codFunLoc').AsInteger := Self.codFuncionario;
          end;
        //data
        if ((mEdData1.Text <> '  /  /    ')and(mEdData2.Text <> '  /  /    '))then
          begin
          qryComissoes.SQL.Add('AND CAST (c.data AS DATE) BETWEEN :dtLoc1 AND :dtLoc2 ');
          qryComissoes.ParamByName('dtLoc1').AsDate := StrToDate(mEdData1.Text);
          qryComissoes.ParamByName('dtLoc2').AsDate := StrToDate(mEdData2.Text);
          end;
        end;
      //vendas
      if(ckBxVendas.Checked=true)then
        begin
        if(ckBxLocacoes.Checked=true)then
          qryComissoes.SQL.Add('UNION ');
        qryComissoes.SQL.Add('SELECT c.codigo,c.cod_funcionario,c.cod_locacao,c.cod_venda,c.valor,c.data, ');
        qryComissoes.SQL.Add('u.nome, ');
        qryComissoes.SQL.Add('v.data_venda,v.observacoes,v.valor_total,v.valor_pago,(v.valor_total-v.valor_pago) AS "Valor_Resta" ');
        qryComissoes.SQL.Add('FROM comissao_funcionario c, usuario u, venda v ');
        qryComissoes.SQL.Add('WHERE c.cod_funcionario=u.codigo ');
        qryComissoes.SQL.Add('AND c.cod_venda=v.codigo ');
        //funcionário
        if (Self.codFuncionario<>0) then
          begin
          qryComissoes.SQL.Add('AND c.cod_funcionario=:codFunVen ');
          qryComissoes.ParamByName('codFunVen').AsInteger := Self.codFuncionario;
          end;
        //data
        if ((mEdData1.Text <> '  /  /    ')and(mEdData2.Text <> '  /  /    '))then
          begin
          qryComissoes.SQL.Add('AND CAST (c.data AS DATE) BETWEEN :dtVen1 AND :dtVen2 ');
          qryComissoes.ParamByName('dtVen1').AsDate := StrToDate(mEdData1.Text);
          qryComissoes.ParamByName('dtVen2').AsDate := StrToDate(mEdData2.Text);
          end;
        end;

      qryComissoes.SQL.Add('order by 6');//data

      qryComissoes.Prepared := true;
      qryComissoes.Open;
      cdsComissoes.Open;
      cdsComissoes.Refresh;

      if (cdsComissoes.RecordCount <> 0) then
        begin
        Application.CreateForm(TqckRepRelatorioComissoesResumo,qckRepRelatorioComissoesResumo);
        qckRepRelatorioComissoesResumo.qrLblRegistros.Caption := IntToStr(cdsComissoes.RecordCount);
        qckRepRelatorioComissoesResumo.Prepare;
        qckRepRelatorioComissoesResumo.Preview;
        qckRepRelatorioComissoesResumo.Free;
        end
      else
        MessageDlg('Nenhum Registro encontrado!',mtInformation,[mbOK],0);
      end//detalhado

    //resumo
    else if(rdBtnComissaoResumo.Checked=true)then
      begin
      //locações
      if(ckBxLocacoes.Checked=true)then
        begin
        qrySomaLocacoes.Close;
        qrySomaLocacoes.SQL.Clear;
        qrySomaLocacoes.SQL.Add('SELECT SUM(c.valor) AS "Total",u.nome ');
        qrySomaLocacoes.SQL.Add('FROM comissao_funcionario c, usuario u ');
        qrySomaLocacoes.SQL.Add('WHERE c.cod_funcionario=u.codigo ');
        qrySomaLocacoes.SQL.Add('AND c.cod_locacao IS NOT null ');
        end;
      //vendas
      if(ckBxVendas.Checked=true)then
        begin
        qrySomaVendas.Close;
        qrySomaVendas.SQL.Clear;
        qrySomaVendas.SQL.Add('SELECT SUM(c.valor) AS "Total",u.nome ');
        qrySomaVendas.SQL.Add('FROM comissao_funcionario c, usuario u ');
        qrySomaVendas.SQL.Add('WHERE c.cod_funcionario=u.codigo ');
        qrySomaVendas.SQL.Add('AND c.cod_venda IS NOT null ');
        end;
      //funcionário
      if (Self.codFuncionario<>0) then
        begin
        //locações
        if(ckBxLocacoes.Checked=true)then
          begin
          qrySomaLocacoes.SQL.Add('AND c.cod_funcionario=:codFunLoc ');
          qrySomaLocacoes.ParamByName('codFunLoc').AsInteger := Self.codFuncionario;
          end;
        //vendas
        if(ckBxVendas.Checked=true)then
          begin
          qrySomaVendas.SQL.Add('AND c.cod_funcionario=:codFunVen ');
          qrySomaVendas.ParamByName('codFunVen').AsInteger := Self.codFuncionario;
          end;
        end;
      //data
      if ((mEdData1.Text <> '  /  /    ')and(mEdData2.Text <> '  /  /    '))then
        begin
        //locações
        if(ckBxLocacoes.Checked=true)then
          begin
          qrySomaLocacoes.SQL.Add('AND CAST (c.data AS DATE) BETWEEN :dtLoc1 AND :dtLoc2 ');
          qrySomaLocacoes.ParamByName('dtLoc1').AsDate := StrToDate(mEdData1.Text);
          qrySomaLocacoes.ParamByName('dtLoc2').AsDate := StrToDate(mEdData2.Text);
          end;
        //vendas
        if(ckBxVendas.Checked=true)then
          begin
          qrySomaVendas.SQL.Add('AND CAST (c.data AS DATE) BETWEEN :dtVen1 AND :dtVen2 ');
          qrySomaVendas.ParamByName('dtVen1').AsDate := StrToDate(mEdData1.Text);
          qrySomaVendas.ParamByName('dtVen2').AsDate := StrToDate(mEdData2.Text);
          end;
        end;

      //locações
      if(ckBxLocacoes.Checked=true)then
        begin
        qrySomaLocacoes.SQL.Add('GROUP BY u.nome ORDER BY u.nome');
        qrySomaLocacoes.Prepared := true;
        qrySomaLocacoes.Open;
        cdsSomaLocacoes.Open;
        cdsSomaLocacoes.Refresh;
        if(cdsSomaLocacoes.RecordCount>0)then
          begin
          temRelResumo := true;
          Application.CreateForm(TfrmVerResumoRelatorioComissoes,frmVerResumoRelatorioComissoes);
          frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[0,0] := 'FUNCIONÁRIO';
          frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[1,0] := 'LOCAÇÕES';
          frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[2,0] := 'VENDAS';
          cdsSomaLocacoes.First;
          while(not(cdsSomaLocacoes.Eof))do
            begin
            frmVerResumoRelatorioComissoes.strGrdComissoes.RowCount := frmVerResumoRelatorioComissoes.strGrdComissoes.RowCount + 1;
            frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[0,i] := cdsSomaLocacoesNOME.AsString;
            frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[1,i] := FormatFloat('#0.00',cdsSomaLocacoesTotal.AsFloat);
            cdsSomaLocacoes.Next;
            inc(i);
            end;
          end;
        end;
      //vendas
      if(ckBxVendas.Checked=true)then
        begin
        qrySomaVendas.SQL.Add('GROUP BY u.nome ORDER BY u.nome');
        qrySomaVendas.Prepared := true;
        qrySomaVendas.Open;
        cdsSomaVendas.Open;
        cdsSomaVendas.Refresh;
        if(cdsSomaVendas.RecordCount>0)then
          begin
          if(temRelResumo=false)then
            begin
            temRelResumo := true;
            Application.CreateForm(TfrmVerResumoRelatorioComissoes,frmVerResumoRelatorioComissoes);
            frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[0,0] := 'FUNCIONÁRIO';
            frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[1,0] := 'LOCAÇÕES';
            frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[2,0] := 'VENDAS';
            end;
          cdsSomaVendas.First;
          while(not(cdsSomaVendas.Eof))do
            begin
            achouFunc := false;
            //percorre grid para achar funcionário
            for x:=1 to frmVerResumoRelatorioComissoes.strGrdComissoes.RowCount do
              begin
              if(frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[0,x]=cdsSomaVendasNOME.AsString)then
                begin
                frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[2,x] := FormatFloat('#0.00',cdsSomaVendasTotal.AsFloat);
                achouFunc := true;
                end;
              end;
            //se não achou funcionário
            if(achouFunc = false)then
              begin
              frmVerResumoRelatorioComissoes.strGrdComissoes.RowCount := frmVerResumoRelatorioComissoes.strGrdComissoes.RowCount + 1;
              frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[0,i] := cdsSomaVendasNOME.AsString;
              frmVerResumoRelatorioComissoes.strGrdComissoes.Cells[1,i] := FormatFloat('#0.00',cdsSomaVendasTotal.AsFloat);
              inc(i);
              end;
            cdsSomaVendas.Next;
            end;
          end;
        end;

      if (temRelResumo=true) then
        begin
        frmVerResumoRelatorioComissoes.ShowModal;
        frmVerResumoRelatorioComissoes.Free;
        end
      else
        MessageDlg('Nenhum Registro encontrado!',mtInformation,[mbOK],0);

      end;//resumo
    end;//continua
end;

end.
