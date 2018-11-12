REM INSERTING into CONFIGURATION_DATA
SET DEFINE OFF;
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('1','0','console_logger','<?xml version = ''1.0'' encoding = ''UTF-8''?><logger factory="common" config="console_nlog"/>',null,to_date('14.10.16','DD.MM.RR'),'1');
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('2','0','console_nlog','<?xml version = ''1.0'' encoding = ''UTF-8''?><nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <targets>
      <target name="FileLog" xsi:type="AsyncWrapper" queueLimit="5000" overflowAction="Discard">
         <target xsi:type="File" fileName="d:\logs\console_logs\log_${processname}_${processid}_${shortdate}.txt" layout="${longdate}|${level}|${logger}|${message}${onexception:${newline}${exception:format=ToString, StackTrace}}${newline}"/>
      </target>
   </targets>
   <rules>
      <logger name="console_logger" minlevel="Debug" writeTo="FileLog"/>
   </rules>
</nlog>',null,to_date('14.10.16','DD.MM.RR'),'1');
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('3','0','security_proxy','<?xml version = ''1.0''?><configuration type="xml">
   <system.serviceModel>
      <bindings>
         <wsHttpBinding>
            <binding name="ServerBinding"/>
         </wsHttpBinding>
      </bindings>
      <client>
         <endpoint address="http://localhost:39310/Security.svc" bindingConfiguration="ServerBinding" binding="wsHttpBinding" contract="FIP.Common.Security.Interface.ISecurity" name="security_proxy"/>
      </client>
   </system.serviceModel>
</configuration>',null,to_date('14.10.16','DD.MM.RR'),'1');
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('4','0','security','<?xml version = ''1.0'' encoding = ''UTF-8''?><security type="db">
   <cleanupPeriod>2000</cleanupPeriod>
   <expirationPeriod>2000</expirationPeriod>
</security>',null,to_date('14.10.16','DD.MM.RR'),'1');
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('5','0','security_wcf','<?xml version = ''1.0'' encoding = ''UTF-8''?><configuration type="xml">
   <system.serviceModel>
      <bindings>
         <wsHttpBinding>
            <binding name="ServerBinding"/>
         </wsHttpBinding>
      </bindings>
      <behaviors>
         <serviceBehaviors>
            <behavior name="ServerBehavior">
               <serviceDebug includeExceptionDetailInFaults="True" httpHelpPageEnabled="True"/>
            </behavior>
         </serviceBehaviors>
      </behaviors>
      <services>
         <service name="security" behaviorConfiguration="ServerBehavior">
            <endpoint address="http://localhost:39310/Security.svc" bindingConfiguration="ServerBinding" binding="wsHttpBinding" contract="Common.Security.Interface.ISecurity" name="security.ISecurity"/>
         </service>
      </services>
   </system.serviceModel>
</configuration>',null,to_date('14.10.16','DD.MM.RR'),'1');
Insert into CONFIGURATION_DATA (CONFIGURATION_DATA_ID,CONFIGURATION_PROFILE_ID,NAME,BODY,SCHEME,CHANGED,CHANGED_BY) values ('6','0','user_Settings','<?xml version = ''1.0'' encoding = ''UTF-8''?><configuration>
   <applicationSettings>
      <system>100</system>
      <group>110</group>
      <culture>ru-RU</culture>
      <defaultPage>805</defaultPage>
   </applicationSettings>
</configuration>',null,to_date('14.10.16','DD.MM.RR'),'1');
