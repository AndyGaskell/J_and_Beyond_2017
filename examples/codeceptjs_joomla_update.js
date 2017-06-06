Feature('CodeceptJS demo');

Scenario('Update Joomla', (I) => {
    I.amOnPage('http://localhost/joomla_test/administrator/');
    I.see('Go to site home page');
    I.saveScreenshot('login_form.png');
    I.fillField('username', 'joomla_test');
    I.fillField('passwd', 'password');
    I.click('Log in');  
    I.saveScreenshot('logged_in.png');
    I.amOnPage('http://localhost/joomla_test/administrator/index.php?option=com_joomlaupdate');
    I.saveScreenshot('update_screen_pre.png');
    I.see('Check for Updates');
    I.click('Check for Updates');    
    I.saveScreenshot('update_screen_check.png'); 
    I.see('Checked for updates')
    I.click('Install the Update');
    I.saveScreenshot('update_screen_install.png'); 
    I.see('successfully updated');
    I.saveScreenshot('update_screen_done.png'); 
})

