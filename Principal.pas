{***  Calculadora de Total (Bs) de pesos v1.0  ***

     Aplicación simple para Android que calcula el monto total
     de una serie de precio/valor. Útil al comprar por peso en
     los abastos, fruterías y ferias de verduras.

     Autor: Ing. Francisco Sáez.

     Calabozo, agosto de 2016
}

unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, System.Rtti, FMX.Layouts, FMX.Grid;

type
  TLista = record
    Valor,Peso,Monto: double
  end;

  TFPrinc = class(TForm)
    NBPrecio: TNumberBox;
    Label1: TLabel;
    Label2: TLabel;
    NBPeso: TNumberBox;
    BAgregar: TButton;
    Label3: TLabel;
    NBMonto: TNumberBox;
    BLimpiar: TButton;
    Grid: TGrid;
    CPrecio: TColumn;
    CPeso: TColumn;
    CMonto: TColumn;
    SpeedButton1: TSpeedButton;
    procedure BAgregarClick(Sender: TObject);
    procedure BLimpiarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridGetValue(Sender: TObject; const Col, Row: Integer;
      var Value: TValue);
    procedure SpeedButton1Click(Sender: TObject);
    procedure NBPesoTyping(Sender: TObject);
    procedure NBPrecioKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure NBPesoKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    procedure LimpiarControles;
  public
    { Public declarations }
  end;

var
  FPrinc: TFPrinc;
  Lista: array of TLista;

implementation

{$R *.fmx}

procedure TFPrinc.LimpiarControles;
begin
  NBPrecio.Value:=0;
  NBPrecio.Text:='0';
  NBPeso.Value:=0;
  NBPeso.Text:='0';
  NBPrecio.SetFocus;
end;

procedure TFPrinc.NBPesoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if KeyChar=#13 then BAgregar.SetFocus;
end;

procedure TFPrinc.NBPesoTyping(Sender: TObject);
begin
  BAgregar.Enabled:=(NBPrecio.Value<>0) and (NBPeso.Value<>0);
end;

procedure TFPrinc.NBPrecioKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if KeyChar=#13 then NBPeso.SetFocus;
end;

procedure TFPrinc.SpeedButton1Click(Sender: TObject);
begin
  ShowMessage('Calculadora de Precio/peso'+#13+#10+
              'v1.0'+#13+#10+
              'Autor: Ing. Francisco J. Sáez S.'+#13+#10+
              'Calabozo, Agosto 2016');
end;

procedure TFPrinc.BAgregarClick(Sender: TObject);
var
  I,Pos: byte;
  Total: Double;
begin
  Total:=0;
  //se agrega una fila:
  Pos:=Length(Lista);
  SetLength(Lista,Pos+1);
  Grid.RowCount:=Grid.RowCount+1;
  //se asignan los valores a los campos:
  Lista[Pos].Valor:=NBPrecio.Value;
  Lista[Pos].Peso:=NBPeso.Value;
  Lista[Pos].Monto:=NBPrecio.Value*NBPeso.Value;
  //se cargan los valores del grid:
  Grid.UpdateColumns;
  //se calcula el total y se muestra:
  for I:=0 to Pos do Total:=Total+Lista[I].Monto;
  NBMonto.Value:=Total;
  LimpiarControles;
  BLimpiar.Enabled:=Length(Lista)>0;
end;

procedure TFPrinc.BLimpiarClick(Sender: TObject);
begin
  BLimpiar.Enabled:=false;
  SetLength(Lista,0);
  Grid.RowCount:=0;
  NBMonto.Value:=0;
  LimpiarControles;
end;

procedure TFPrinc.FormShow(Sender: TObject);
begin
  BLimpiar.Enabled:=false;
  BAgregar.Enabled:=false;
  LimpiarControles;
end;

procedure TFPrinc.GridGetValue(Sender: TObject; const Col, Row: Integer;
  var Value: TValue);
begin
  case Col of
    0: Value:=FormatFloat('#,##0.00',Lista[Row].Valor);
    1: Value:=FormatFloat('#,##0.00',Lista[Row].Peso);
    2: Value:=FormatFloat('#,##0.00',Lista[Row].Monto);
  end;
end;

end.
