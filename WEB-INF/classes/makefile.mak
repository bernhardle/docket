# (c) Bernhard Schupp; Frankfurt-München-Frankfurt; 2001-2004
# Makefile für den Borland 5.2 'make.exe'

.java.class :
	javac -deprecation -O -g:none -classpath C:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\lib\common\servlet.jar;. $<

all: 		data \
		dynamic \
		html \
		misc \
		servlet

dynamic:	dynamic\inputchecker\InputChecker.class \
		dynamic\inputchecker\InputCheckerBase.class \
		dynamic\inputchecker\InputCheckerImpl.class \
		dynamic\meta\Meta.class \
		dynamic\meta\MetaImpl.class \
		dynamic\listfetch\ListFetch.class \
		dynamic\listfetch\AsdListFetch.class \
		dynamic\listfetch\UserListFetch.class \
		dynamic\listfetch\DTypeListFetch.class \
		dynamic\listfetch\TypeBformListFetch.class \
		dynamic\listfetch\TypeUBformListFetch.class \
		dynamic\listfetch\TypeboundedformListFetch.class \
		dynamic\listfetch\TypeunboundedformListFetch.class 

misc :	misc\comparison\ID.class \
		misc\comparison\IDCompare.class \
		misc\Jump.class \
		misc\JumpTarget.class \
		misc\File.class \
		misc\Helper.class \
		misc\Icon.class \
		misc\Item.class \
		misc\Image.class \
		misc\Menue.class \
		misc\Color.class \
		misc\Caption.class \
		misc\Option.class \
		misc\Ticket.class \
		misc\Detail.class \
		misc\Event.class \
		misc\Style.class \
		misc\Pair.class \
		misc\Result.class \
		misc\OIterator.class \
		misc\OList.class \
		misc\ObjectWrapper.class \
		misc\Permissions.class \
		misc\ConnectionInfo.class \
		misc\Date.class \
		misc\Deadline.class \
		misc\Notification.class \
		misc\AutoContinuation.class \
		misc\AutoDeadline.class \
		misc\AutoDeadlinePreview.class \
		misc\AutoNotification.class 

data : 	dynamic \
		misc \
		html \
		data\DataSourceException.class \
		data\ConnectionHandler.class \
		data\DataSourceBase.class \
		data\DataSourceConfiguration.class \
		data\DataSourceLayout.class \
		data\DataSourceForm.class \
		data\DataSourceScheduleRead.class \
		data\DataSourceSchedule.class

html : 	misc \
		html\form\AreaInput.class \
		html\form\CheckboxInput.class \
		html\form\DateInput.class \
		html\form\DetailInput.class \
		html\form\HiddenInput.class \
		html\form\HiddenDateInput.class \
		html\form\InputFormRow.class \
		html\form\ImageInput.class \
		html\form\Input.class \
		html\form\InputBase.class \
		html\form\RadioInput.class \
		html\form\SelectInput.class \
		html\form\SubmitInput.class \
		html\form\TextInput.class \
		html\form\TextInputPseudo.class \
		html\form\TextInputPassword.class \
		html\form\TextInputStandard.class \
		html\form\Form.class \
		html\form\FormAdapter.class \
		html\form\FormImpl.class \
		html\frame\Description.class \
		html\frame\Frame.class \
		html\frame\Inner.class \
		html\frame\Outer.class \
		html\text\IconHook.class \
		html\text\TableFormat.class \
		html\text\DetailFormat.class \
		html\text\DetailFormatLong.class \
		html\text\DetailFormatMedium.class \
		html\text\EventFormat.class \
		html\text\EventFormatLong.class \
		html\text\ConnectionInfoFormat.class \
		html\list\Bucket.class \
		html\list\BucketHolder.class \
		html\list\BucketImpl.class \
		html\list\Row.class \
		html\list\IconTextRow.class \
		html\list\IconDetailRow.class \
		html\list\IconConInfoRow.class \
		html\list\TextRow.class \
		html\list\TextTextRow.class \
		html\template\Description.class \
		html\template\TemplatePage.class \
		html\RawPage.class \
		html\RawPageImpl.class \
		html\BasePage.class \
		html\BasePageImpl.class \
		html\FormBasePage.class \
		html\BasePageAdapter.class \
		html\BodyPage.class \
		html\BodyPageImpl.class \
		html\BodyPageAdapter.class \
		html\ListPage.class \
		html\ListPageImpl.class \
		html\FormBodyPage.class \
		html\FormListPage.class \
		html\FormListPageImpl.class \
		html\LoginPage.class \
		html\CaptionPage.class \
		html\NavigatorPage.class  

servlet : 	misc \
		html \
		data \
		AddAsdServlet.class \
		AddCommentServlet.class \
		AddNotificationServlet.class \
		AddTypeServlet.class \
		AddUserServlet.class \
		CaptionServlet.class \
		ChangePasswordServlet.class \
		ConnectionInfoServlet.class \
		DataminingServlet.class \
		DateFormatException.class \
		DetailServlet.class \
		DeleteUserServlet.class \
		DeleteServlet.class \
		ErrorListServlet.class \
		InnerFrameServlet.class \
		InsertServlet.class \
		IntroServlet.class \
		ListServlet.class \
		LoginServlet.class \
		MenueServlet.class \
		ModifyUserServlet.class \
		MyBasicHttpServlet.class \
		NavigatorServlet.class \
		OuterFrameServlet.class \
		OverviewServlet.class \
		SearchServlet.class \
		ServiceFormsServlet.class \
		SelectionServlet.class \
		SimpleTemplateServlet.class \
		SQLServlet.class \
		WorkloadServlet.class 

doc :	
	javadoc -d c:\Programme\Apache-Group\jakarta-tomcat-3.3.1a\webapps\terminebeta\doc\api \
	html\*.java data\*.java misc\*.java dynamic\meta\*.java dynamic\listfetch\*.java dynamic\inputchecker\*.java \
	misc\comparison\*.java html\form\*.java html\frame\*.java html\text\*.java html\list\*.java html\template\*.java \
	-quiet \
	-footer "Terminkalender API (c) Bernhard Schupp; Frankfurt-M&uuml;nchen-Frankfurt; 2001-2004" \
	-link http://bernhardle.orgdns.org/terminebeta/doc/api/ \
	-link file:///X:\Common\Dokumente\Java\j2sdk1.4.0_03\docs\api\ 
	
	
# Junk Section:
# -linksource \
# http://bernhardle.orgdns.org/terminebeta/doc/api/
# file:///C:/Programme/Apache-Group/jakarta-tomcat-3.3.1a/webapps/terminebeta/doc/api/