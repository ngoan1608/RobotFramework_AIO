[Code]
// Check Android component is selected
function IsAndroidSelected: Boolean;
begin
  // Check if the "Android" component is selected
  Result := IsComponentSelected('Android');
end;

// Process the failed installation of component
procedure ProcessFailedInstallation(var Component: String);
var
   Msg: String;
   MsgBoxResult: Integer;
begin
   // Installation failed - Ask user whether to proceed or not
   Msg := 'Failed to install ' + Component + '. Do you want to continue?';
   MsgBoxResult := MsgBox(Msg, mbConfirmation, MB_YESNO);

   if MsgBoxResult = IDNO then
   begin
      // User chooses not to terminate the whole installation
      Abort;
   end;
end;

// Check whether Node.js is installed before
function IsNodeInstalled: Boolean;
var
  ResultCode: Integer;
begin
  // Use the Exec function to run a command that checks for Node.js
  if Exec(ExpandConstant('{cmd}'), '/C node -v', '', SW_HIDE,
    ewWaitUntilTerminated, ResultCode) then
  begin
    // If the command succeeds, Node.js is installed
    Result := True;
  end
  else
  begin
    // If the command fails, Node.js is not installed
    Result := False;
  end;
end;

// Process Node.js installation by executing *.msi file
procedure InstallNodeJS;
var
  Msg: String;
  NodeInstallerPath: String;
  ResultCode: Integer;
  Component: String;
begin
   // path to Node.js installer
   NodeInstallerPath := ExpandConstant('..\android\node.msi');

   if Exec(NodeInstallerPath, '', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
   begin
      // Check the ResultCode for success
      if ResultCode = 0 then
      begin
         // Move to next step after successful installation
         Exit;
      end;
   end

   // process failed installation
   Component := 'Node.js'
   ProcessFailedInstallation(Component)
end;

// Verify and process Node.js installation
procedure ProcessNodeJSInstallation;
var
   Msg: String;
   MsgBoxResult: Integer;
   NodeVersion: String;
begin
   // Check if Node.js is already installed
   if IsNodeInstalled then
   begin
      // Display a message box with Node.js version and ask for reinstallation
      Msg := 'Node.js is already installed. Do you want to reinstall it?';
      MsgBoxResult := MsgBox(Msg, mbConfirmation, MB_YESNO);

      if MsgBoxResult = IDNO then
      begin
         // User chooses not to reinstall, exit nodejs installation
         Exit;
      end;
   end;

   // install nodejs
   InstallNodeJS
end;

// Check installation status of appium server
function IsAppiumInstalled: Boolean;
var
   ResultCode: Integer;
begin
   // Use the Exec function to run a command that checks for Appium
   if Exec(ExpandConstant('{cmd}'), '/C appium -v', '', SW_HIDE,
      ewWaitUntilTerminated, ResultCode) then
   begin
      // If the command succeeds, Appium is installed
      Result := True;
   end
   else
   begin
      // If the command fails, Appium is not installed
      Result := False;
   end;
end;

procedure InstallAppiumInspector;
var
   AppiumInstallerPath: String;
   ResultCode: Integer;
   Msg: String;
   Component: String;
begin
   // path to Appium-Inspector installer
   AppiumInstallerPath := ExpandConstant('..\android\Appium-Inspector.exe');

   // Display a message box for user confirmation
   // Msg := 'Do you want to install Appium Inspector?' + #13#10 + 'Path: ' + AppiumInstallerPath;
   // if MsgBox(Msg, mbConfirmation, MB_YESNO) = IDYES then
   // begin
   // Execute the Appium-Inspector installer
   if Exec(AppiumInstallerPath, '', '', SW_HIDE, ewWaitUntilTerminated, ResultCode) then
   begin
      // Check the ResultCode for success
      if ResultCode = 0 then
      begin
         // Move to next step after successful installation
         Exit;
      end;
   end
   // end;

   // process failed installation
   Component := 'Appium-Inspector'
   ProcessFailedInstallation(Component)
end;