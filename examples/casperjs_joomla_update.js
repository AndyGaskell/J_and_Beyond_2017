var casper = require('casper').create({
    verbose: true,
    //logLevel: "debug"
});

var current_version = "3.7.2";

// increase the viewport
casper.options.viewportSize = {width: 1200, height: 1200};

// get a datestamp field
var m = new Date();
var now = m.getUTCFullYear() +"-"+ (m.getUTCMonth()+1) +"-"+ m.getUTCDate() + "_" + m.getUTCHours() + "-" + m.getUTCMinutes();

casper.echo("CasperJS Update Script Started");

// get the first passed in value
var domain = casper.cli.get(0);
var username = casper.cli.get(1);
var password = casper.cli.get(2);

casper.echo("domain: " + domain);
casper.echo("Date and Time: " + now);

var img_sufix = "_" + domain + "_" + now;


casper.start('https://' + domain + '/administrator', function() {
    // login
    this.fill('form#form-login', { 
        username: " + username + ",
        passwd: " + password + "
    }, true);
});


casper.then(function() {
    // grab the screen
    this.capture('screencaptures/jadmin1' + img_sufix + '.png');
});

// print the version
casper.then(function() {
    var footer_text = this.fetchText('#status .btn-toolbar .btn-group p');
    this.echo('Footer is : ' + footer_text);
    var alert_message_is_current_version = footer_text.search(current_version);
    casper.echo("alert_message_is_current_version: " + alert_message_is_current_version); 
    if ( alert_message_is_current_version == -1 ) {
        casper.echo("**** Not the current version " + current_version + " ****");   

        casper.then(function() {
            // go to the update page
            casper.open('https://' + domain + '/administrator/index.php?option=com_joomlaupdate').then(function() {
                this.capture('screencaptures/jadmin2' + img_sufix + '.png');
                casper.echo("logged in");
            });
        });

        casper.then(function() {
            // grab the screen
            this.capture('screencaptures/jadmin3' + img_sufix + '.png');
            casper.echo("capture screen");
        });

        casper.then(function() {
            // Click on purge button
            this.click('#toolbar-purge button');
            casper.echo("purged updates");
        });

        casper.then(function() {
            // grab the screen
            this.capture('screencaptures/jadmin4' + img_sufix + '.png');
            casper.echo("capture screen");    
        });

        casper.then(function() {
            // see if the update button is there
            if(!casper.exists('#adminForm button')){
                // button does not exist
                casper.echo("update button does not exist, now exit");
                this.exit();
            } else {
                // Click on update button
                this.click('#adminForm button');
                casper.echo("clicked update");    
            }    
        });

        casper.then(function() {
            casper.wait(40000, function() {
                this.echo('Waited some seconds');
            });
        });

        casper.then(function() {
            // grab the screen
            this.capture('screencaptures/jadmin5' + img_sufix + '.png');
            casper.echo("capture screen");    
        });

        casper.then(function() {
            // go to the update page
            casper.open('https://' + domain + '/administrator/index.php?option=com_installer&view=database').then(function() {
                this.capture('screencaptures/jadmin6' + img_sufix + '.png');
                casper.echo("logged in");
            });
        }); 
    }
});

casper.run(); 