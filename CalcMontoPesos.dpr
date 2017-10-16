program CalcMontoPesos;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.
