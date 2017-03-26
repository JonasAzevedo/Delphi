{@unit RLParser - Implementação do componente de avaliação de expressões. }
unit RLParser;

interface

uses
  Classes, Contnrs, Math, TypInfo, 
{$ifndef DELPHI5}
  Variants,
{$endif}
  SysUtils;

type
  {@type TRLParserTokenKind - Tipo de token. :}
  TRLParserTokenKind=(tkNull,tkUnknown,
                      tkIdentifier,tkValue,tkLiteral,tkOperator,
                      tkEnterBrackets,tkExitBrackets,tkBracketsBreak,
                      tkCodeEnter,tkCodeBreak,tkCodeExit);
  {/@type}

  TRLParserOperation=(opNull,                                                    // none
                      opIdentifier,opValue,opLiteral,                            // identifier or const
                      opSum,opSubtract,opMultiply,opDivide,opPower,opRoot,       // binary math operation
                      opPlus,opMinus,opNot,                                      // unary operation
                      opGreater,opLess,opEqual,opInequal,opNotLess,opNotGreater, // relational operation
                      opOr,opAnd,                                                // logical operation
                      opSet,                                                     // attribution
                      opInline);                                                 // inline code

  TRLParserNode=class;
  TRLParserFunction=class;
  TRLParserFunctionList=class;
  TRLParserValue=class;
  TRLParserValueList=class;
  TRLParserParamList=class;

  {@type TRLParserOnIdentifierEvent - Identificador encontrado. Este evento é disparado para todo identificador encontrado na expressão.
   Sender é o expressionparser que invocou o evento;
   Identifier é uma sequência alfanumérica que é o nome da variável encontrada;
   Params é um vetor variant que contém a lista de parâmetros que seguem o identificador, caso seja uma chamada a função;
   Result é o resultado da expressão que pode ser informado pelo usuário.
   @links TRLExpressionParser, TRLExpressionParser.OnIdentifier, TRLExpressionParser.OnUnknown. :/}
  TRLParserOnIdentifierEvent=procedure(Sender:TObject; const Identifier:string; Params:variant; var Result:variant) of object;

  {@type TRLParserOnTokenEvent - Evento para sequências de caracteres.
   Sender é o expressionparser que invocou o evento;
   Token é uma sequência qualquer de caracteres que tem a mesma semântica e que pode ser traduzida pelo usuário;
   Kind é o tipo de sequência do modo como foi identificada pelo parser.
   @links TRLExpressionParser, TRLParserTokenKind. :/}
  TRLParserOnTokenEvent=procedure(Sender:TObject; var Token:string; var Kind:TRLParserTokenKind) of object;

  {@type TRLParserOnException - Evento disparado quando ocorre uma exceção durante a tradução da expressão.
   Sender é o expressionparser que invocou o evento;
   E é uma referência para o objeto exceção;
   Result é o valor assumido.
   @links TRLExpressionParser. :/}
  TRLParserOnException=procedure(Sender:TObject; var E:Exception; var Result:variant) of object;

  TRLParserOption =(poScanComponents);
  TRLParserOptions=set of TRLParserOption;

  {@type TRLParserOnFindAgregateEvent - Oportunidade para procura de um elemtno agregado. :/}
  TRLParserOnFindAgregateEvent=procedure(Sender:TObject; Owner:TPersistent; const Name:string; var Agregate:TPersistent) of object;

  {@type TRLParserOnGetAttributeEvent - Oportunidade para obter um atributo de um objeto. :/}
  TRLParserOnGetAttributeEvent=procedure(Sender:TObject; Owner:TPersistent; const Name:string; var Value:variant) of object;

  {@type TRLParserOnSetAttributeEvent - Oportunidade para alterar um atributo de um objeto. :/}
  TRLParserOnSetAttributeEvent=procedure(Sender:TObject; Owner:TPersistent; const Name:string; const Value:variant; var Handled:boolean) of object;

  { TRLExpressionParser }

  {@class TRLExpressionParser - Avaliador de expressões.
   @pub }
  TRLExpressionParser=class(TComponent)
  private
    { Private declarations }
    fExprBuffer  :PChar;
    fExprBuffLen :integer;
    fExprBuffCh  :integer;
    //
    fNextCh      :char;
    fNextToken   :string;
    fNextKind    :TRLParserTokenKind;
    fLastToken   :string;
    fLastKind    :TRLParserTokenKind;
    fFunctionList:TRLParserFunctionList;
    fValueList   :TRLParserValueList;
    fIdentifierId:integer;
    fRootNode    :TRLParserNode;
    fExpression  :string;
    fOptions     :TRLParserOptions;
    fParams      :TRLParserParamList;
    //
    fResourceProc :TRLParserOnIdentifierEvent;
    fOnUnknown    :TRLParserOnIdentifierEvent;
    fOnIdentifier :TRLParserOnIdentifierEvent;
    fTokenProc    :TRLParserOnTokenEvent;
    fOnToken      :TRLParserOnTokenEvent;
    fOnException  :TRLParserOnException;
    //
    fFindAgregateProc:TRLParserOnFindAgregateEvent;
    fSetAttributeProc:TRLParserOnSetAttributeEvent;
    fGetAttributeProc:TRLParserOnGetAttributeEvent;
    //
    function    NextCh(var aCh:char):boolean;
    procedure   RefuseCh(var aCh:char);
    function    NextValidCh(var aCh:char):boolean;
    function    NextToken(var aToken:string; var aKind:TRLParserTokenKind):boolean;
    function    CompileNode:TRLParserNode;
    procedure   ResolveIdentifier(const aIdentifier:string; aId:integer; aParams:variant; var aResult:variant);
    procedure   ResolveToken(var aToken:string; var aKind:TRLParserTokenKind);
    function    TryEvalNode(aNode:TRLParserNode):variant;
    function    EvalNode(aNode:TRLParserNode):variant;
    procedure   Compile(const aExpression:string; var aRoot:TRLParserNode);
    procedure   ParseFunction(const aDeclaration:string; var aName:string; aParams:TStrings);
    function    InternalEvaluate(const aExpression:string):variant;
    procedure   SetExpression(const Value:string);
    function    GetGlobalProperty(const aPropPath:string):variant;
    function    SetGlobalProperty(const aPropPath:string; aValue:variant):boolean;
    function    DoResolveIdentifier(const aIdentifier:string; aParams:variant):variant;
    function    GetPropValue(aPersistent:TPersistent; const aPropName:string):variant;
    function    SetPropValue(aPersistent:TPersistent; const aPropName:string; aValue:variant):boolean;
    //
    function    FindDependentPart(aOwner: TPersistent; const aName: string): TPersistent;
    function    FindPropertyPair(aOwner: TPersistent; const aPropPath: string; var aPersistent: TPersistent; var aPropName: string): boolean;

  public
    { Public declarations }

    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;

    {@method CreateFunction - Adiciona uma função pré-definida.
     Uma função para o expressionparser é uma expressão associada a um símbolo com parâmetros,
     na forma: "NOME(P1,P2,...,Pn)=EXPRESSÃO".
     Ex.: Min(p1,p2)=If(p1<p2,p1,p2) :/}
    function    CreateFunction(const aDeclaration:string; const aExpression:string):TRLParserFunction;

    {@method CreateValue - Associa um símbolo a uma constante. Quando o expressionparser tenta resolver uma expressão,
     procura pelos símbolos nas listas de símbolos e funções pré-definidas antes de disparar o evento OnUnknown.
     @links builtin:build-in. :/}
    function    CreateValue(const aName:string; const aValue:variant):TRLParserValue;
    
    {@method Evaluate - Avalia uma expressão e retorna o resultado.
     Chamado sem parâmetros indica que o cálculo deve ser executado com a prop Expression.
     O parâmetro aExpression é uma fórmula cujos elementos podem ser de qualquer tipo de dado primário: integer,
     float, string e boolean.
     Podem ser incluídos e serão resolvidos automaticamente: nomes de campos, funções e símbolos pré-definidos, e
     funções built-in.
     @links Expression, BuiltIn:build-in. :}
    function    Evaluate:variant; overload;
    function    Evaluate(const aExpression:string):variant; overload;
    {/@method}

    {@method Invalidate - Invalida a última compilação feita para a expressão. Força a recompilaçào na próxima avaliação.
     @links Evaluate, Clear. :/}
    procedure   Invalidate;

    {@method Clear - Esvazia a lista de valores e funções pré-definidos.
     @links ValueList, FunctionList, CreateFunction, CreateValue. :/}
    procedure   Clear;

    {@prop FunctionList - Referência para a lista de funções pré-definidas. :/}
    property    FunctionList:TRLParserFunctionList   read fFunctionList;

    {@prop ValueList - Referência para a lista de valores pré-definidos. :/}
    property    ValueList   :TRLParserValueList      read fValueList;
    
    property    IdentifierId    :integer                       read fIdentifierId;
    //
    property    ResourceProc    :TRLParserOnIdentifierEvent    read fResourceProc     write fResourceProc;
    property    TokenProc       :TRLParserOnTokenEvent         read fTokenProc        write fTokenProc;
    property    FindAgregateProc:TRLParserOnFindAgregateEvent  read fFindAgregateProc write fFindAgregateProc;
    property    SetAttributeProc:TRLParserOnSetAttributeEvent  read fSetAttributeProc write fSetAttributeProc;
    property    GetAttributeProc:TRLParserOnGetAttributeEvent  read fGetAttributeProc write fGetAttributeProc;

  published
    { Published declarations }

    {@prop Expression - Expressão padrão a avaliar.
     A expressão pode ser simples como a soma de dois números ou nomes de campos de uma
     tabela. Pode ser também um script complexo em dialeto pascal acessando componentes
     e modificando suas propriedades.
     O resultado será sempre o valor do último número, literal, identificador ou operação
     mencionado na expressão. :/}
    property    Expression:string read fExpression write SetExpression;

    {@prop Options - Opções de escopo para resolução de identificadores. :/}
    property    Options:TRLParserOptions read fOptions write fOptions default [poScanComponents];
    {@event OnIdentifier - Evento disparado antes da avaliação de um identificador.
     @links TRLParserOnIdentifierEvent. :/}
    property    OnIdentifier:TRLParserOnIdentifierEvent read fOnIdentifier write fOnIdentifier;

    {@event OnUnknown - Evento disparado quando um identificador não pode ser resolvido pelo parser.
     @links TRLParserOnIdentifierEvent. :/}
    property    OnUnknown   :TRLParserOnIdentifierEvent read fOnUnknown    write fOnUnknown;

    {@event OnToken - Evento chamado para cada sequência de caracteres encontrada.
     Os operadores e estruturas de controle do expressionparser são simbólicos e escritos em inglês. Utilize este
     evento para customizar o dialéto utilizado.
     @links TRLParserOnTokenEvent. :/}
    property    OnToken     :TRLParserOnTokenEvent   read fOnToken      write fOnToken;

    {@event OnException - Evento disparado quando ocorre uma exceção na tradução da expressão.
     @links TRLParserOnException. :/}
    property    OnException :TRLParserOnException    read fOnException  write fOnException;
  end;
  {/@class}

  {@article BuiltIn - Funções e constantes pré-compiladas do componente TRLExpressionParser.
   PI - Retorna o valor de PI = 3.1415926535897932385;
   TRUE - Constante booleana equivalente a verdadeiro;
   FALSE - Constante booleana equivalente a falso;
   NULL - Constante equivalente ao variante Null;
   MINOR(V1,V2,..,VN) - Função que retorna o menor dos valores passados;
   MAJOR(V1,V2,..,VN) - Função que retorna o maior dos valores passados;
   IF(C,V1,V2) - Função que retorna o valor V1 se a condição C for verdadeira, e V2, caso contrário. /}

  TRLParserParam=class
  private
    fFunction:TRLParserFunction;
    fName    :string;
    fValue   :variant;
  public
    constructor Create(aFunction:TRLParserFunction);
    destructor  Destroy; override;
    //
    procedure   Clear;
    //
    property    Name :string  read fName  write fName;
    property    Value:variant read fValue write fValue;
  end;

  TRLParserParamList=class(TObjectList)
  public
    procedure Assign(aParams:variant); overload;
    procedure Assign(aParams:array of variant); overload;
    procedure Reset;
    function  ByIndex(aIndex:integer):TRLParserParam;
    function  ByName(const aName:string):TRLParserParam;
    //
    property  Params[aIndex:integer]:TRLParserParam read ByIndex; default;
  end;

  TRLParserFunction=class(TPersistent)
  private
    fParser      :TRLExpressionParser;
    fName        :string;
    fExpression  :string;
    fRootNode    :TRLParserNode;
    fParams      :TRLParserParamList;
    //
    procedure   SetExpression(const Value:string);
    //
    function    InternalEvaluate:variant;
  public
    constructor Create(aParser:TRLExpressionParser); reintroduce;
    destructor  Destroy; override;

    {@method Invalidate - Invalida a última compilação feita para a expressão. Força a recompilaçào na próxima avaliação.
     @links Evaluate. :/}
    procedure   Invalidate;
    
    function    Evaluate:variant; overload;
    function    Evaluate(aParams:variant):variant; overload;
    function    Evaluate(aParams:array of variant):variant; overload;
    //
    property    Parser:TRLExpressionParser read fParser;
    property    Params:TRLParserParamList  read fParams;
  published
    property    Expression:string read fExpression write SetExpression;
    property    Name      :string read fName       write fName;
  end;

  TRLParserFunctionList=class(TObjectList)
  public
    function ByIndex(aIndex:integer):TRLParserFunction;
    function ByName(const aName:string):TRLParserFunction;
    //
    property Functions[aIndex:integer]:TRLParserFunction read ByIndex; default;
  end;

  TRLParserValue=class(TPersistent)
  private
    fParser:TRLExpressionParser;
    fName  :string;
    fValue :variant;
  public
    constructor Create(aParser:TRLExpressionParser); reintroduce;
    destructor  Destroy; override;
    //
    property    Parser:TRLExpressionParser read fParser;
    //
    property    Name  :string  read fName  write fName;
    property    Value :variant read fValue write fValue;
  end;

  TRLParserValueList=class(TObjectList)
  public
    function ByIndex(aIndex:integer):TRLParserValue;
    function ByName(const aName:string):TRLParserValue;
    //
    property Values[aIndex:integer]:TRLParserValue read ByIndex; default;
  end;

  TRLParserNode=class
  private
    fParser    :TRLExpressionParser;
    fParentNode:TRLParserNode;
    fOperation :TRLParserOperation;
    fChildren  :TObjectList;
    fValue     :variant;
    fPriority  :byte;
    fIsolated  :boolean;
    //
    procedure   SetParentNode(const Value:TRLParserNode);
    function    GetChildren(aIndex:integer):TRLParserNode;
    function    GetChildCount:integer;
  protected
    procedure   InsertBefore(aNode:TRLParserNode);
    procedure   AddChild(aNode:TRLParserNode);
    function    GetRootDistance:integer;
    //
    property    ChildList:TObjectList read fChildren;
  public
    constructor Create(aParser:TRLExpressionParser; const aOperation:TRLParserOperation; const aValue:string='');
    destructor  Destroy; override;
    //
    function    Eval:variant;
    //
    property    ParentNode:TRLParserNode read fParentNode write SetParentNode;
    property    Priority  :byte          read fPriority   write fPriority;
    property    Isolated  :boolean       read fIsolated   write fIsolated;
    //
    property    Parser    :TRLExpressionParser read fParser;
    property    Operation :TRLParserOperation  read fOperation;
    property    Value     :variant             read fValue;
    //
    property    Children[aIndex:integer]:TRLParserNode read GetChildren;
    property    ChildCount:integer                     read GetChildCount;
  end;

  TRLParserInlineNode=class(TRLParserNode)
  end;
  
{/@unit}

implementation

const
  DIGITSET       =['0'..'9'];
  ALPHASET       =['A'..'Z','a'..'z','_'];
  ALPHASETEX     =ALPHASET+DIGITSET+['.'];
  NUMSET         =DIGITSET;
  NUMSETEX       =NUMSET+['.','E','e','-','+'];
  QUOTESET       =['''','"'];
  MATHOPSET      =['+','-','*','/','^','\'];
  RELATIONALOPSET=['>','<','=','#'];
  LOGICALOPSET   =['|','&'];
  UNARYOPSET     =['+','-','!'];
  ALLOPSET       =MATHOPSET+RELATIONALOPSET+LOGICALOPSET+UNARYOPSET;
  NULLSET        =[#32,#13,#10,#9];

procedure Abort(const aMsg:string);
begin
  raise EAbort.Create(aMsg);
end;

function TokenToOperation(const aToken:string; aUnary:boolean=False):TRLParserOperation;
begin
  // binary math operation
  if not aUnary and (aToken='+') then
    Result:=opSum
  else if not aUnary and (aToken='-') then
    Result:=opSubtract
  else if aToken='*' then
    Result:=opMultiply
  else if aToken='/' then
    Result:=opDivide
  else if aToken='^' then
    Result:=opPower
  else if aToken='\' then 
    Result:=opRoot
  // unary operation
  else if aUnary and (aToken='+') then
    Result:=opPlus
  else if aUnary and (aToken='-') then
    Result:=opMinus
  else if aUnary and (aToken='!') then
    Result:=opNot
  // relational operation  
  else if aToken='>' then
    Result:=opGreater
  else if aToken='<' then
    Result:=opLess
  else if aToken='=' then
    Result:=opEqual
  else if (aToken='#') or (aToken='<>') then
    Result:=opInequal
  else if aToken='>=' then
    Result:=opNotLess
  else if aToken='<=' then
    Result:=opNotGreater
  // logical operation  
  else if aToken='|' then
    Result:=opOr
  else if aToken='&' then
    Result:=opAnd
  // attribution  
  else if aToken=':=' then
    Result:=opSet
  //
  else
    Result:=opNull;
end;

function OperationToToken(const aOperation:TRLParserOperation):string;
begin
  case aOperation of
    // binary math operation
    opSum       : Result:='+';
    opSubtract  : Result:='-';
    opMultiply  : Result:='*';
    opDivide    : Result:='/';
    opPower     : Result:='^';
    opRoot      : Result:='\';
    // unary operation
    opPlus      : Result:='+';
    opMinus     : Result:='-';
    opNot       : Result:='!';
    // relational operation
    opGreater   : Result:='>';
    opLess      : Result:='<';
    opEqual     : Result:='=';
    opInequal   : Result:='#';
    opNotLess   : Result:='>=';
    opNotGreater: Result:='<=';
    // logical operation
    opOr        : Result:='|';
    opAnd       : Result:='&';
    // attribution
    opSet       : Result:=':=';
  else
    Result:='';
  end;
end;

function OperationPriority(const aOperation:TRLParserOperation):byte;
begin
  case aOperation of
    // attribution
    opSet       : Result:=0;
    // relational operation
    opEqual     : Result:=1;
    opInequal   : Result:=2;
    opGreater   : Result:=3;
    opLess      : Result:=4;
    opNotLess   : Result:=5;
    opNotGreater: Result:=6;
    // logical operation
    opOr        : Result:=7;
    opAnd       : Result:=8;
    // binary math operation
    opSum       : Result:=9;
    opSubtract  : Result:=10;
    opMultiply  : Result:=11;
    opDivide    : Result:=12;
    opPower     : Result:=13;
    opRoot      : Result:=14;
    // unary operation
    opPlus      : Result:=15;
    opMinus     : Result:=16;
    opNot       : Result:=17;
  else
    Result:=255;
  end;
end;

{ TRLExpressionParser }

constructor TRLExpressionParser.Create(aOwner:TComponent);
begin
  fExprBuffer  :=nil;
  fExprBuffLen :=0;
  fExprBuffCh  :=0;
  fNextCh      :=#0;
  fNextToken   :='';
  fNextKind    :=tkNull;
  fLastToken   :='';
  fLastKind    :=tkNull;
  fFunctionList:=nil;
  fValueList   :=nil;
  fIdentifierId:=0;
  fExpression  :='';
  fRootNode    :=nil;
  fOptions     :=[poScanComponents];
  fParams      :=nil;
  //
  fResourceProc    :=nil;
  fOnUnknown       :=nil;
  fOnIdentifier    :=nil;
  fTokenProc       :=nil;
  fOnToken         :=nil;
  fOnException     :=nil;
  fFindAgregateProc:=nil;
  fSetAttributeProc:=nil;
  fGetAttributeProc:=nil;
  //
  fFunctionList:=TRLParserFunctionList.Create;
  fValueList   :=TRLParserValueList.Create;
  //
  inherited Create(aOwner);
end;

destructor TRLExpressionParser.Destroy;
begin
  Clear;
  //
  if Assigned(fRootNode) then
    fRootNode.Free;
  if Assigned(fFunctionList) then
    fFunctionList.Free;
  if Assigned(fValueList) then
    fValueList.Free;
  //
  inherited;
end;

procedure TRLExpressionParser.Clear;
begin
  if Assigned(fFunctionList) then
    fFunctionList.Clear;
  if Assigned(fValueList) then
    fValueList.Clear;
end;

function TRLExpressionParser.NextCh(var aCh:char):boolean;
begin
  if fNextCh<>#0 then
  begin
    aCh    :=fNextCh;
    fNextCh:=#0;
  end
  else if fExprBuffCh<fExprBuffLen then
  begin
    aCh:=fExprBuffer[fExprBuffCh];
    inc(fExprBuffCh);
  end
  else
    aCh:=#0;
  //  
  Result:=(aCh<>#0);
end;

procedure TRLExpressionParser.RefuseCh(var aCh:char);
begin
  if aCh<>#0 then
    fNextCh:=aCh;
end;

// skip spaces and control chars
function TRLExpressionParser.NextValidCh(var aCh:char):boolean;
begin
  while NextCh(aCh) and (aCh in NULLSET) do;
  Result:=(aCh<>#0);
end;

function TRLExpressionParser.NextToken(var aToken:string; var aKind:TRLParserTokenKind):boolean;
var
  ch,quote:char;
  pointed :boolean;
  exped   :boolean;
  expsignd:boolean;
begin
  if fNextKind<>tkNull then
  begin
    aToken    :=fNextToken;
    aKind     :=fNextKind;
    fNextToken:='';
    fNextKind :=tkNull;
  end
  else
  begin
    aToken:='';
    aKind :=tkNull;
    //
    if NextValidCh(ch) then
      if ch in ALPHASET then
      begin
        aKind :=tkIdentifier;
        aToken:=ch;
        while NextCh(ch) and (ch in ALPHASETEX) do
          aToken:=aToken+ch;
        RefuseCh(ch);
      end
      else if ch in NUMSET then
      begin
        pointed :=False;
        exped   :=False;
        expsignd:=False;
        aKind   :=tkValue;
        aToken  :=ch;
        while NextCh(ch) and (ch in NUMSETEX) do
        begin
          if ch='.' then
            if exped then
              Abort('Incorrect number format at '+IntToStr(fExprBuffCh)+'!')
            else if not pointed then
              pointed:=True
            else
              Abort('Incorrect number format at '+IntToStr(fExprBuffCh)+'!')
          else if ch in ['e','E'] then
            if not exped then
              exped:=True
            else
              Abort('Incorrect number format at '+IntToStr(fExprBuffCh)+'!')
          else if ch in ['+','-'] then
            if not exped then
              Break
            else if not expsignd then
              expsignd:=True
            else
              Abort('Incorrect number format at '+IntToStr(fExprBuffCh)+'!');
          aToken:=aToken+ch;
        end;
        RefuseCh(ch);
      end
      else if ch in QUOTESET then
      begin
        quote :=ch;
        aKind :=tkLiteral;
        aToken:='';
        repeat
          while NextCh(ch) and (ch<>quote) do
            aToken:=aToken+ch;
          if ch=quote then
            if NextValidCh(ch) and (ch=quote) then
            begin
              aToken:=aToken+ch;
              continue;
            end;  
          Break;                
        until False;
        RefuseCh(ch);
      end
      else if ch in ALLOPSET then
      begin
        aKind :=tkOperator;
        aToken:=ch;
        if ch in ['>','<'] then
          if NextValidCh(ch) then
            if (ch='=') or ((ch='>') and (aToken='<')) then
              aToken:=aToken+ch
            else
              RefuseCh(ch);
      end
      else if ch=':' then
      begin
        aKind :=tkUnknown;
        aToken:=ch;
        if NextValidCh(ch) then
          if ch='=' then
          begin
            aKind :=tkOperator;
            aToken:=aToken+ch;
          end
          else
            RefuseCh(ch);
      end
      else if ch='(' then
      begin
        aKind :=tkEnterBrackets;
        aToken:=ch;
      end
      else if ch=')' then
      begin
        aKind :=tkExitBrackets;
        aToken:=ch;
      end
      else if ch=',' then
      begin
        aKind :=tkBracketsBreak;
        aToken:=ch;
      end
      else if ch='{' then
      begin
        aKind :=tkCodeEnter;
        aToken:=ch;
      end
      else if ch=';' then
      begin
        aKind :=tkCodeBreak;
        aToken:=ch;
      end
      else if ch='}' then
      begin
        aKind :=tkCodeExit;
        aToken:=ch;
      end
      else
      begin
        aKind :=tkUnknown;
        aToken:=ch;
      end;  
  end;      
  //
  if aKind in [tkUnknown,tkIdentifier,tkValue,tkLiteral,tkOperator] then
    ResolveToken(aToken,aKind);
  fLastToken:=aToken;
  fLastKind :=aKind;
  //
  Result:=(aKind<>tkNull);
end;

procedure TRLExpressionParser.ResolveToken(var aToken:string; var aKind:TRLParserTokenKind);
begin
  // defaults
  if aKind=tkIdentifier then
    if AnsiSameText(aToken,'not') then
    begin
      aToken:='!';
      aKind :=tkOperator;
    end
    else if AnsiSameText(aToken,'and') then
    begin
      aToken:='&';
      aKind :=tkOperator;
    end
    else if AnsiSameText(aToken,'or') then
    begin
      aToken:='|';
      aKind :=tkOperator;
    end
    else if AnsiSameText(aToken,'div') then
    begin
      aToken:='/';
      aKind :=tkOperator;
    end
    else if AnsiSameText(aToken,'begin') then
    begin
      aToken:='{';
      aKind :=tkCodeEnter;
    end
    else if AnsiSameText(aToken,'end') then
    begin
      aToken:='}';
      aKind :=tkCodeExit;
    end;
  // internal defined use
  if Assigned(fTokenProc) then
    fTokenProc(Self,aToken,aKind);
  // user defined
  if Assigned(fOnToken) then
    fOnToken(Self,aToken,aKind);
end;

function TRLExpressionParser.CompileNode:TRLParserNode;
var
  token:string;
  kind :TRLParserTokenKind;
  node :TRLParserNode;
  unary:boolean;
  last :TRLParserNode;
  prior:TRLParserNode;
  this :TRLParserNode;
begin
  Result:=nil;
  last  :=nil;
  unary :=True;
  //
  while NextToken(token,kind) do
  begin
    case kind of
      tkNull         : // impossible
                       ;
      tkUnknown      : // error
                       ;
      tkIdentifier   : // variable or const name
                       begin
                         node:=TRLParserNode.Create(Self,opIdentifier,token);
                         if last<>nil then
                           last.AddChild(node)
                         else
                           Result:=node;
                         last:=node;
                       end;
      tkValue        : // numeric value float or int
                       begin
                         node:=TRLParserNode.Create(Self,opValue,token);
                         if last<>nil then
                           last.AddChild(node)
                         else
                           Result:=node;
                         last:=node;
                       end;
      tkLiteral      : // quoted string
                       begin
                         node:=TRLParserNode.Create(Self,opLiteral,token);
                         if last<>nil then
                           last.AddChild(node)
                         else
                           Result:=node;
                         last:=node;
                       end;
      tkOperator     : // operators with priority
                       begin
                         if token[1] in UNARYOPSET then
                           if last=nil then
                             unary:=True
                           else if last.Operation in [opIdentifier,opValue,opLiteral] then
                           else if last.Isolated then
                           else
                             unary:=True;
                         node:=TRLParserNode.Create(Self,TokenToOperation(token,unary),token);
                         if last<>nil then
                         begin
                           prior:=nil;
                           while (node.Priority<last.Priority) and Assigned(last.ParentNode) do
                           begin
                             prior:=last;
                             last :=last.ParentNode;
                           end;
                           if node.Priority<last.Priority then
                           begin
                             last.InsertBefore(node);
                             if not Assigned(node.ParentNode) then
                               Result:=node;
                           end
                           else if Assigned(prior) then
                             prior.InsertBefore(node)
                           else
                             last.AddChild(node);
                         end
                         else
                           Result:=node;
                         last:=node;
                       end;
      tkEnterBrackets: // brackets
                       begin
                         repeat
                           node:=CompileNode;
                           this:=node;
                           if node<>nil then
                             if last<>nil then
                               last.AddChild(node)
                             else
                               Result:=node;
                           if fLastKind=tkBracketsBreak then
                             if (last=nil) or (last.Operation<>opIdentifier) then
                               Abort('Parameter list not suported at '+IntToStr(fExprBuffCh)+'!')
                             else
                           else if fLastKind<>tkExitBrackets then
                             Abort('Brackets expected at '+IntToStr(fExprBuffCh)+'!');
                         until fLastKind=tkExitBrackets;
                         if (last=nil) or (last.Operation<>opIdentifier) then
                           last:=this;
                       end;  
      tkBracketsBreak: // ends a parameter
                       Break;
      tkExitBrackets : // ends brackets
                       Break;
      tkCodeEnter    : // code piece
                       begin
                         node:=TRLParserNode.Create(Self,opInline,token);
                         if last<>nil then
                           last.AddChild(node)
                         else
                           Result:=node;
                         if (last<>nil) and (last.Operation=opIdentifier) then
                         else
                           last:=node;
                         this:=node;
                         //
                         repeat
                           node:=CompileNode;
                           if node<>nil then
                             this.AddChild(node);
                           if not (fLastKind in [tkCodeBreak,tkCodeExit]) then
                             Abort('Inline expected at '+IntToStr(fExprBuffCh)+'!');
                         until fLastKind=tkCodeExit;
                       end;
      tkCodeBreak    : // code separator
                       Break;
      tkCodeExit     : // ends code piece
                       Break;
    end;
    //
    unary:=False;
  end;
  //
  if Assigned(Result) then
    with Result do
    begin
      Priority:=255;
      Isolated:=True;
    end;
end;

procedure TRLExpressionParser.Compile(const aExpression:string; var aRoot:TRLParserNode);
begin
  fExprBuffLen:=length(aExpression);
  fExprBuffer :=@aExpression[1];
  fExprBuffCh :=0;
  //
  fNextCh     :=#0;
  fNextToken  :='';
  fNextKind   :=tkNull;
  fLastToken  :='';
  fLastKind   :=tkNull;
  //
  aRoot:=CompileNode;
end;

procedure TRLExpressionParser.ParseFunction(const aDeclaration:string; var aName:string; aParams:TStrings);
var
  i,l:integer;
  n:string;
begin
  l:=length(aDeclaration);
  i:=1;
  // parse name
  while (i<=l) and (aDeclaration[i] in NULLSET) do
    inc(i);
  if i>l then
    Abort('Identifier name expected!');
  if not (aDeclaration[i] in ALPHASET) then
    Abort('Identifier expected!');
  aName:='';
  repeat
    aName:=aName+aDeclaration[i];
    inc(i);
  until (i>l) or not (aDeclaration[i] in ALPHASETEX);
  // parse params
  aParams.Clear;
  while (i<=l) and (aDeclaration[i] in NULLSET) do
    inc(i);
  if i>l then
    Exit;
  if aDeclaration[i]<>'(' then
    Abort('Brackets expected!');
  inc(i);
  while i<=l do
  begin
    while (i<=l) and (aDeclaration[i] in NULLSET) do
      inc(i);
    if (i>l) or (aDeclaration[i]=')') then
      Break;
    if not (aDeclaration[i] in ALPHASET) then
      Abort('Identifier expected!');
    n:='';
    repeat
      n:=n+aDeclaration[i];
      inc(i);
    until (i>l) or not (aDeclaration[i] in ALPHASETEX);
    aParams.Add(n);    
    while (i<=l) and (aDeclaration[i] in NULLSET) do
      inc(i);
    if i>l then
      Abort('Unclosed brackets!');
    if aDeclaration[i]=')' then
      Break
    else if aDeclaration[i]<>',' then
      Abort('Sintax error!');
    inc(i);
  end;
end;

function TRLExpressionParser.CreateFunction(const aDeclaration:string; const aExpression:string):TRLParserFunction;
var
  pars:TStringList;
  fnam:string;
  func:TRLParserFunction;
  i   :integer;
begin
  pars:=TStringList.Create;
  try
    ParseFunction(aDeclaration,fnam,pars);
    //
    func:=FunctionList.ByName(fnam);
    if func<>nil then
      func.Free;
    //
    Result:=TRLParserFunction.Create(Self);
    with Result do
    begin
      Name      :=fnam;
      Expression:=aExpression;
      for i:=0 to pars.Count-1 do
        TRLParserParam.Create(Result).Name:=pars[i];
    end;
  finally
    pars.Free;
  end;
end;

function TRLExpressionParser.CreateValue(const aName:string; const aValue:variant):TRLParserValue;
var
  valu:TRLParserValue;
begin
  valu:=ValueList.ByName(aName);
  if valu<>nil then
    valu.Free;
  Result:=TRLParserValue.Create(Self);
  Result.Name :=aName;
  Result.Value:=aValue;
end;

function ArrayMinor(aValues:variant):variant;
var
  i:integer;
begin
  Result:=Unassigned;
  for i:=VarArrayLowBound(aValues,1) to VarArrayHighBound(aValues,1) do
    if VarIsEmpty(Result) or (aValues[i]<Result) then
      Result:=aValues[i];
end;

function ArrayMajor(aValues:variant):variant;
var
  i:integer;
begin
  Result:=Unassigned;
  for i:=VarArrayLowBound(aValues,1) to VarArrayHighBound(aValues,1) do
    if VarIsEmpty(Result) or (aValues[i]>Result) then
      Result:=aValues[i];
end;

function TRLExpressionParser.GetPropValue(aPersistent:TPersistent; const aPropName:string):variant;
var
  info:PPropInfo;
begin
  Result:=Unassigned;
  if Assigned(fGetAttributeProc) then
    fGetAttributeProc(Self,aPersistent,aPropName,Result);
  if VarIsEmpty(Result) then
    if aPropName='' then
      if Assigned(aPersistent) then
        Result:='['+aPersistent.ClassName+']'
      else
        Result:='nil'
    else
    begin
      info:=GetPropInfo(aPersistent,aPropName);
      if info<>nil then
        case info^.PropType^^.Kind of
          tkInteger,
          tkChar,
          tkWChar      : Result:=GetOrdProp(aPersistent,info);
          tkEnumeration: Result:=GetEnumProp(aPersistent,info);
          tkSet        : Result:=GetSetProp(aPersistent,info);
          tkFloat      : Result:=GetFloatProp(aPersistent,info);
          tkMethod     : Result:=info^.PropType^.Name;
          tkString,
          tkLString,
          tkWString    : Result:=GetStrProp(aPersistent,info);
          tkVariant    : Result:=GetVariantProp(aPersistent,info);
          tkInt64      : Result:=GetInt64Prop(aPersistent,info)+0.0;
        end;
    end;
end;

function TRLExpressionParser.SetPropValue(aPersistent:TPersistent; const aPropName:string; aValue:variant):boolean;
var
  info:PPropInfo;
begin
  Result:=False;
  if aPropName<>'' then
  begin
    info:=GetPropInfo(aPersistent,aPropName);
    if info<>nil then
      case info^.PropType^^.Kind of
        tkInteger,
        tkChar,
        tkWChar      : begin
                         SetOrdProp(aPersistent,info,aValue);
                         Result:=True;
                       end;
        tkEnumeration: begin
                         SetEnumProp(aPersistent,info,string(aValue));
                         Result:=True;
                       end;
        tkSet        : begin
                         SetSetProp(aPersistent,info,string(aValue));
                         Result:=True;
                       end;
        tkFloat      : begin
                         SetFloatProp(aPersistent,info,aValue);
                         Result:=True;
                       end;
        tkMethod     : ;
        tkString,
        tkLString,
        tkWString    : begin
                         SetStrProp(aPersistent,info,string(aValue));
                         Result:=True;
                       end;
        tkVariant    : begin
                         SetVariantProp(aPersistent,info,aValue);
                         Result:=True;
                       end;
        tkInt64      : begin
                         SetInt64Prop(aPersistent,info,Integer(aValue));
                         Result:=True;
                       end;
      end;
  end;
  if not Result and Assigned(fSetAttributeProc) then
    fSetAttributeProc(Self,aPersistent,aPropName,aValue,Result);
end;

function TRLExpressionParser.FindDependentPart(aOwner:TPersistent; const aName:string):TPersistent;
  function FindComponent(aOwner:TComponent; const aName:string):TComponent;
  var
    i:integer;
  begin
    Result:=nil;
    if AnsiSameText(aOwner.Name,aName) then
      Result:=aOwner
    else
    begin
      i:=0;
      while (i<aOwner.ComponentCount) and not AnsiSameText(aOwner.Components[i].Name,aName) do
        Inc(i);
      if i<aOwner.ComponentCount then
        Result:=aOwner.Components[i];
    end;    
  end;
  function FindAgregate(aOwner:TPersistent; const aName:string):TPersistent;
  var
    info:PPropInfo;
    obj :TObject;
  begin
    Result:=nil;
    info:=GetPropInfo(aOwner,aName);
    if Assigned(info) and (info^.PropType^^.Kind=tkClass) then
    begin
      obj:=TObject(GetOrdProp(aOwner,info));
      if Assigned(obj) and (obj is TPersistent) then
        Result:=TPersistent(obj);
    end;
  end;
begin
  Result:=nil;
  if Assigned(fFindAgregateProc) then
  begin
    fFindAgregateProc(Self,aOwner,aName,Result);
    if Result<>nil then
      Exit;
  end;
  if aOwner is TComponent then
  begin
    Result:=FindComponent(TComponent(aOwner),aName);
    if Result<>nil then
      Exit;
  end;
  if Result=nil then
  begin
    Result:=FindAgregate(aOwner,aName);
    if Result<>nil then
      Exit;
  end;
end;

function TRLExpressionParser.FindPropertyPair(aOwner:TPersistent; const aPropPath:string; var aPersistent:TPersistent; var aPropName:string):boolean;
var
  parent:TPersistent;
  found :TPersistent;
  path  :string;
  part  :string;
  i     :integer;
begin
  Result:=False;
  parent:=aOwner;
  path  :=aPropPath;
  repeat
    i:=Pos('.',path);
    if i=0 then
      i:=Length(path)+1;
    part:=Copy(path,1,i-1);
    Delete(path,1,i);
    if part='' then
      Break;
    // procura parte dependente, podendo apelar para o usuário  
    found:=FindDependentPart(parent,part);
    // se não achou a parte dependente, então ela talvez seja uma prop
    if found=nil then
      // mas, se ainda houver mais partes a procurar, então desiste
      if path<>'' then
        Break
      else
      begin
        aPersistent:=parent;
        aPropName  :=part;
        Result     :=True;
        Break;
      end
    // se encontrou a parte e não há outras partes a procurar, então retorna a parte sem prop
    else if path='' then
    begin
      aPersistent:=parent;
      aPropName  :='';
      Result     :=True;
      Break;
    end
    // senão, procura dentro da parte encontrada
    else
      parent:=found;
  until False;    
end;

function TRLExpressionParser.GetGlobalProperty(const aPropPath:string):variant;
var
  parent:TPersistent;
  prop  :string;
begin
  if FindPropertyPair(Self.Owner,aPropPath,parent,prop) then
    Result:=GetPropValue(parent,prop)
  else
    Result:=Unassigned;
end;

function TRLExpressionParser.SetGlobalProperty(const aPropPath:string; aValue:variant):boolean;
var
  parent:TPersistent;
  prop  :string;
begin
  if FindPropertyPair(Self.Owner,aPropPath,parent,prop) then
    Result:=SetPropValue(parent,prop,aValue)
  else
    Result:=False;
end;

function TRLExpressionParser.DoResolveIdentifier(const aIdentifier:string; aParams:variant):variant;
var
  fncitem:TRLParserFunction;
  valitem:TRLParserValue;
  prmitem:TRLParserParam;
begin
  Result:=Unassigned;
  // o usuário resolve previamente
  if Assigned(fOnIdentifier) then
  begin
    // user defined
    fOnIdentifier(Self,aIdentifier,aParams,Result);
    if not VarIsEmpty(Result) then
      Exit;
  end;
  // function params
  if Assigned(fParams) then
  begin
    prmitem:=fParams.ByName(aIdentifier);
    if Assigned(prmitem) then
    begin
      Result:=prmitem.Value;
      Exit;
    end;
  end;
  // stored functions //
  fncitem:=fFunctionList.ByName(aIdentifier);
  if Assigned(fncitem) then
  begin
    Result:=fncitem.Evaluate(aParams);
    Exit;
  end;
  // stored values //
  valitem:=fValueList.ByName(aIdentifier);
  if Assigned(valitem) then
  begin
    Result:=valitem.Value;
    Exit;
  end;
  // predefined constants //
  // pi
  if AnsiSameText(aIdentifier,'pi') then
    Result:=Pi
  // boolean
  else if AnsiSameText(aIdentifier,'true') then
    Result:=True
  else if AnsiSameText(aIdentifier,'false') then
    Result:=False
  else if AnsiSameText(aIdentifier,'null') then
    Result:=Null
  // predefined functions //
  // min & max
  else if AnsiSameText(aIdentifier,'minor') then
    Result:=ArrayMinor(aParams)
  else if AnsiSameText(aIdentifier,'major') then
    Result:=ArrayMajor(aParams)
  else
  begin
    // internal use only
    if Assigned(fResourceProc) then
      fResourceProc(Self,aIdentifier,aParams,Result);
    if VarIsEmpty(Result) and (poScanComponents in fOptions) then
      Result:=GetGlobalProperty(aIdentifier);
    // user defined
    if VarIsEmpty(Result) and Assigned(fOnUnknown) then
      fOnUnknown(Self,aIdentifier,aParams,Result);
  end;
end;

procedure TRLExpressionParser.ResolveIdentifier(const aIdentifier:string; aId:integer; aParams:variant; var aResult:variant);
var
  savedid:integer;
begin
  // save id
  savedid:=fIdentifierId;
  try
    fIdentifierId:=aId;
    aResult      :=DoResolveIdentifier(aIdentifier,aParams);
    if VarIsEmpty(aResult) then
      Abort('Undefined identifier "'+aIdentifier+'"');
  finally
    // restore id
    fIdentifierId:=savedid;
  end;
end;

function TRLExpressionParser.EvalNode(aNode:TRLParserNode):variant;
var
  i:integer;
  p:variant;
begin
  case aNode.Operation of
    opNull      : Result:=Unassigned;
    //
    opIdentifier: begin
                    // builtin
                    if AnsiSameText(aNode.Value,'if') then
                      if aNode.ChildCount<>3 then
                        Abort('Wrong number of arguments')
                      else if aNode.Children[0].Eval then
                        Result:=aNode.Children[1].Eval
                      else
                        Result:=aNode.Children[2].Eval
                    else
                    begin
                      if aNode.ChildCount=0 then
                        p:=Unassigned
                      else
                      begin
                        p:=VarArrayCreate([0,aNode.ChildCount-1],varVariant);
                        for i:=0 to aNode.ChildCount-1 do
                          p[i]:=aNode.Children[i].Eval;
                      end;
                      ResolveIdentifier(aNode.Value,aNode.GetRootDistance,p,Result);
                    end;  
                  end;
    opValue     : Result:=aNode.Value;
    opLiteral   : Result:=aNode.Value;
    //
    opSum       : Result:=aNode.Children[0].Eval+aNode.Children[1].Eval;
    opSubtract  : Result:=aNode.Children[0].Eval-aNode.Children[1].Eval;
    opMultiply  : Result:=aNode.Children[0].Eval*aNode.Children[1].Eval;
    opDivide    : Result:=aNode.Children[0].Eval/aNode.Children[1].Eval;
    opPower     : Result:=Power(aNode.Children[0].Eval,aNode.Children[1].Eval);
    opRoot      : Result:=Power(aNode.Children[0].Eval,1/aNode.Children[1].Eval);
    //
    opPlus      : Result:=aNode.Children[0].Eval;
    opMinus     : Result:=-aNode.Children[0].Eval;
    opNot       : Result:=not aNode.Children[0].Eval;
    //
    opGreater   : Result:=aNode.Children[0].Eval>aNode.Children[1].Eval;
    opLess      : Result:=aNode.Children[0].Eval<aNode.Children[1].Eval;
    opEqual     : Result:=(aNode.Children[0].Eval=aNode.Children[1].Eval);
    opInequal   : Result:=aNode.Children[0].Eval<>aNode.Children[1].Eval;
    opNotLess   : Result:=aNode.Children[0].Eval>=aNode.Children[1].Eval;
    opNotGreater: Result:=aNode.Children[0].Eval<=aNode.Children[1].Eval;
    //
    opOr        : Result:=aNode.Children[0].Eval or aNode.Children[1].Eval;
    opAnd       : Result:=aNode.Children[0].Eval and aNode.Children[1].Eval;
    //
    opSet       : begin
                    if aNode.Children[0].Operation<>opIdentifier then
                      Abort('Left side cannot be Assigned');
                    Result:=aNode.Children[1].Eval;
                    if (poScanComponents in fOptions) and SetGlobalProperty(aNode.Children[0].Value,Result) then
                    else
                      CreateValue(aNode.Children[0].Value,Result);
                  end;
    //
    opInline    : for i:=0 to aNode.ChildCount-1 do
                    Result:=aNode.Children[i].Eval;
  else
    Result:=Unassigned;
  end;
end;

procedure TRLExpressionParser.Invalidate;
begin
  if Assigned(fRootNode) then
    fRootNode.Free;
  fRootNode:=nil;
end;

function TRLExpressionParser.TryEvalNode(aNode:TRLParserNode):variant;
begin
  Result:=Unassigned;
  if Assigned(aNode) then
    try
      Result:=aNode.Eval;
    except
      on e:Exception do
        if Assigned(fOnException) then
          fOnException(Self,e,Result)
        else
          raise;
    end;
end;

function TRLExpressionParser.InternalEvaluate(const aExpression:string):variant;
var
  root:TRLParserNode;
begin
  root:=nil;
  try
    Compile(aExpression,root);
    Result:=TryEvalNode(root);
  finally
    if Assigned(root) then
      root.Free;
  end;
end;

function TRLExpressionParser.Evaluate:variant;
begin
  if not Assigned(fRootNode) then
    Compile(fExpression,fRootNode);
  Result:=TryEvalNode(fRootNode);
end;

function TRLExpressionParser.Evaluate(const aExpression:string):variant;
begin
  Result:=InternalEvaluate(aExpression);
end;

procedure TRLExpressionParser.SetExpression(const Value:string);
begin
  if Value=fExpression then
    Exit;
  fExpression:=Value;
  Invalidate;
end;

{ TRLParserNode }

constructor TRLParserNode.Create(aParser:TRLExpressionParser; const aOperation:TRLParserOperation; const aValue:string='');
var
  e:integer;
  v:double;
begin
  fParser    :=aParser; 
  fParentNode:=nil;
  fChildren  :=nil;
  fIsolated  :=False;
  fOperation :=aOperation;
  fPriority  :=OperationPriority(fOperation);
  //
  case fOperation of
    opIdentifier: fValue:=aValue;
    opValue     : begin
                    val(aValue,v,e);
                    fValue:=v;
                  end;  
    opLiteral   : fValue:=aValue;
  end;
  //
  fChildren:=TObjectList.Create;
  //
  inherited Create;
end;

destructor TRLParserNode.Destroy;
begin
  if Assigned(fParentNode) then
    fParentNode.ChildList.Extract(Self);
  if Assigned(fChildren) then
    fChildren.Free;
  //
  inherited;
end;

function TRLParserNode.Eval:variant;
begin
  Result:=fParser.EvalNode(Self);
end;

procedure TRLParserNode.InsertBefore(aNode:TRLParserNode);
begin
  aNode.ParentNode:=Self.ParentNode;
  Self.ParentNode :=aNode;
end;

procedure TRLParserNode.AddChild(aNode:TRLParserNode);
begin
  aNode.ParentNode:=Self;
end;

function TRLParserNode.GetRootDistance:integer;
begin
  if ParentNode<>nil then
    Result:=ParentNode.ChildList.IndexOf(Self)+1+ParentNode.GetRootDistance
  else
    Result:=0;
end;

procedure TRLParserNode.SetParentNode(const Value:TRLParserNode);
begin
  if Assigned(fParentNode) then
    fParentNode.ChildList.Extract(Self);
  fParentNode:=Value;
  if Assigned(fParentNode) then
    fParentNode.ChildList.Add(Self);
end;

function TRLParserNode.GetChildren(aIndex:integer):TRLParserNode;
begin
  Result:=TRLParserNode(fChildren[aIndex]);
end;

function TRLParserNode.GetChildCount:integer;
begin
  Result:=fChildren.Count;
end;

{ TRLParserFunction }

constructor TRLParserFunction.Create(aParser:TRLExpressionParser);
begin
  fParser      :=aParser;
  fName        :='';
  fExpression  :='';
  fParams      :=nil;
  fRootNode    :=nil;
  //
  fParams:=TRLParserParamList.Create;
  //
  inherited Create;
  //
  if Assigned(Parser) and (Parser.FunctionList.IndexOf(Self)=-1) then
    Parser.FunctionList.Add(Self);
end;

destructor TRLParserFunction.Destroy;
begin
  if Assigned(Parser) then
    Parser.FunctionList.Extract(Self);
  //
  if Assigned(fRootNode) then
    fRootNode.free;
  if Assigned(fParams) then
    fParams.Free;
  //
  inherited;
end;

function TRLParserFunction.InternalEvaluate:variant;
var
  savedparams:TRLParserParamList;
begin
  if not Assigned(fRootNode) then
    Parser.Compile(fExpression,fRootNode);
  savedparams:=Parser.fParams;
  try
    Parser.fParams:=Self.fParams;
    Result:=Parser.TryEvalNode(fRootNode);
  finally
    Parser.fParams:=savedparams;
  end;
end;

function TRLParserFunction.Evaluate:variant;
begin
  Params.Reset;
  Result:=InternalEvaluate;
end;

function TRLParserFunction.Evaluate(aParams:variant):variant;
begin
  Params.Assign(aParams);
  Result:=InternalEvaluate;
end;

function TRLParserFunction.Evaluate(aParams:array of variant):variant;
begin
  Params.Assign(aParams);
  Result:=InternalEvaluate;
end;

procedure TRLParserFunction.Invalidate;
begin
  if Assigned(fRootNode) then
    fRootNode.Free;
  fRootNode:=nil;
end;

procedure TRLParserFunction.SetExpression(const Value:string);
begin
  if Value=fExpression then
    Exit;
  fExpression:=Value;
  Invalidate;
end;

{ TRLParserFunctionList }

function TRLParserFunctionList.ByIndex(aIndex:integer):TRLParserFunction;
begin
  Result:=TRLParserFunction(Items[aIndex]);
end;

function TRLParserFunctionList.ByName(const aName:string):TRLParserFunction;
var
  i:integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do
    if AnsiSameText(ByIndex(i).Name,aName) then
    begin
      Result:=ByIndex(i);
      Break;
    end;
end;

{ TRLParserParam }

constructor TRLParserParam.Create(aFunction:TRLParserFunction);
begin
  fFunction:=aFunction;
  fName    :='';
  fValue   :=Unassigned;
  //
  inherited Create;
  //
  if Assigned(fFunction) then
    fFunction.Params.Add(Self);
end;

destructor TRLParserParam.Destroy;
begin
  if Assigned(fFunction) then
    fFunction.Params.Extract(Self);
  //
  inherited;
end;

procedure TRLParserParam.Clear;
begin
  fValue:=Unassigned;
end;

{ TRLParserParamList }

function TRLParserParamList.ByIndex(aIndex:integer):TRLParserParam;
begin
  Result:=TRLParserParam(Items[aIndex]);
end;

function TRLParserParamList.ByName(const aName:string):TRLParserParam;
var
  i:integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do
    if AnsiSameText(ByIndex(i).Name,aName) then
    begin
      Result:=ByIndex(i);
      Break;
    end;
end;

procedure TRLParserParamList.Reset;
var
  i:integer;
begin
  for i:=0 to Count-1 do
    ByIndex(i).Clear;
end;

procedure TRLParserParamList.Assign(aParams:variant);
var
  i,j,i1,i2:integer;
begin
  Reset;
  if (VarType(aParams) and varArray)=varArray then
  begin
    i1:=VarArrayLowBound(aParams,1);
    i2:=VarArrayHighBound(aParams,1);
    for i:=i1 to i2 do
    begin
      j:=i-i1;
      if j<Count then
        ByIndex(j).Value:=aParams[i];
    end;
  end
  else if not VarIsEmpty(aParams) and (Count>0) then
    ByIndex(0).Value:=aParams;
end;

procedure TRLParserParamList.Assign(aParams:array of variant);
var
  i:integer;
begin
  Reset;
  for i:=0 to High(aParams) do
    if i<Count then
      ByIndex(i).Value:=aParams[i];
end;


{ TRLParserValue }

constructor TRLParserValue.Create(aParser:TRLExpressionParser);
begin
  fParser:=aParser;
  fName  :='';
  fValue :=Unassigned;
  //
  inherited Create;
  //
  if Assigned(Parser) and (Parser.ValueList.IndexOf(Self)=-1) then
    Parser.ValueList.Add(Self);
end;

destructor TRLParserValue.Destroy;
begin
  if Assigned(Parser) then
    Parser.ValueList.Extract(Self);
  //
  inherited;
end;

{ TRLParserValueList }

function TRLParserValueList.ByIndex(aIndex:integer):TRLParserValue;
begin
  Result:=TRLParserValue(Items[aIndex]);
end;

function TRLParserValueList.ByName(const aName:string):TRLParserValue;
var
  i:integer;
begin
  Result:=nil;
  for i:=0 to Count-1 do
    if AnsiSameText(ByIndex(i).Name,aName) then
    begin
      Result:=ByIndex(i);
      Break;
    end;
end;

end.

