import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forextainment/widgets/AppButtonWidget.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TERMS OF SERVICE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome to Forextainment!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                  '''These Terms and Conditions includes important disclosures and information related to certain products and services. Your use of FOREXTAINMENT App is subject to these Terms and Conditions.
                  These Terms and Conditions are a binding agreement between you and FOREXTAINMENT. Your access to and use of this App constitutes your acceptance of these Terms and Conditions and any other legal notices and statements contained on this App including any revisions that may be made to FOREXTAIMENT Terms and Conditions from time to time. Therefore, it is recommended that the User read them carefully every time they want to access the aforementioned App. In case of not accepting the clauses established in these Conditions of Use, the User must abstain from accessing and/or using the services and/or contents made available in said App, proceeding to abandon them. Your use of FOREXTAINMENT App is governed by the version of the Apps Terms and Conditions in effect on the date FOREXTAINMENT App is accessed by you.
              FOREXTAINMENT may modify these Terms and Conditions at any time and without prior notice. You should review the most current version of these Terms and Conditions by clicking on the App Terms and Conditions hyperlink located at the bottom of the menu page. Your continued access to and use of this App constitutes your acceptance of these App Terms and Conditions as modified. The only notice of changes or modification to these App Terms and Conditions will be by FOREXTAINMENT publishing revised App Terms and Conditions on this App; FOREXTAINMENT may not separately notify you of any changes or modifications.
              These App Terms and Conditions are in addition to any other agreements between you and FOREXTAINMENT, including any customer or account agreements, and any other agreements that govern your use of information, content, tools, products and services available on and through the FOREXTAINMENT App.
              In order to use the Services offered on the App, it is a necessary condition that Users are of legal age, so, with the acceptance of the following Terms and Conditions, the User states that they are of legal age, as well as that they have the necessary capacity to contract the Services offered on the App.
              In relation to the above, the User will be, in any case, responsible for the accuracy and veracity of the data provided to FOREXTAINMENT through the registration form. Those users under age who are interested in contracting the Services will require prior authorization from their parents or legal guardians.
                  '''),
              Text(
                'Distribution and Responsibility of Visitors',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''By using this App, you are agreeing that you bear full responsibility for your own research, trading and investment decisions and you also agree that FOREXTAINMENT shall not be liable for any decision made or action taken by you or others in reliance upon any Information published by FOREXTAINMENT. The Information available on or through this App is only for your general information and use and is not intended to address your particular requirements. In particular, any Information is in the nature of general information and is for general informational purposes only. The Information is not personalized for you or any other recipient, does not constitute any form of advice or recommendation or investment advice by FOREXTAINMENT or other users and is not and should not be considered to be an individualized investment recommendation. Such Information is not intended to be relied upon by you in making (or refraining to make) any specific investment or other decisions.
FOREXTAINMENT is not responsible or liable in any manner for, and makes no representations or warranties of any kind regarding, the accuracy, completeness, quality, reliability or usefulness of the Information.
The information on this App is not intended for distribution to, or use by, any person in any country or jurisdiction where such distribution or use would be contrary to local law or regulation. None of the services or products referred to in FOREXTAINMENT App are available to persons residing in any country where the provision of such services or products would be contrary to local law or regulation.
It is the responsibility of visitors to this App to ascertain the terms of and comply with any local law or regulation to which they are subject. Nothing on the FOREXTAINMENT App shall be considered a solicitation to buy or an offer to sell any product or service to any person in any jurisdiction where such offer, solicitation, purchase or sale would be unlawful under the laws of such jurisdiction.
       '''),
              Text(
                'Limitations on Investment Guidance and Professional Advice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''The FOREXTAINMENT App are not intended to provide legal, tax or investment advice. You are solely responsible for determining whether any investment, investment strategy or related transaction is appropriate for you based on your personal investment objectives, financial circumstances and risk tolerance. You should consult your legal or tax professional regarding your specific situation.      '''),
              SizedBox(height: 16),
              Text(
                'Accuracy of Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''While FOREXTAINMENT has made every effort to ensure the accuracy of the information on this App, the information and content on the App is subject to change without notice and is provided for the sole purpose of assisting traders to make independent investment decisions. FOREXTAINMENT has taken reasonable measures to ensure the accuracy of the information on the App. However, FOREXTAINMENT does not guarantee its accuracy, and will not accept liability for any loss or damage that may arise directly or indirectly from the content or your inability to access the App, for any delay in or failure of the transmission or the receipt of any instruction or notifications sent through this App.
                    '''),
              SizedBox(height: 16),
              Text(
                'Indemnification',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''As a condition of your use of the FOREXTAINMENT App, you agree to indemnify and hold FOREXTAINMENT and its Third-Party Content providers harmless from and against any and all claims, losses, liability, costs and expenses (including but not limited to attorneys' fees) arising from your use of the FOREXTAINMENT App, or from your violation of these Terms.
                   '''),
              SizedBox(height: 16),
              Text(
                'Termination',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''Unauthorized access of this App is a breach of FOREXTAINMENT Terms and a violation of the law. You agree not to access this App by any means other than the interfaces FOREXTAINMENT provides for use in accessing them
FOREXTAINMENT reserves the right to, and may terminate or temporarily suspend your access to all or any part of the App, for any reason with or without cause and without prior notice for conduct that FOREXTAINMENT believes violates FOREXTAINMENT's Terms or for any other reason in its sole discretion. FOREXTAINMENT will bear no responsibility or liability from such action.
         '''),
              SizedBox(height: 16),
              Text(
                  'You may not use, or allow others to use your FOREXTAINMENT registration to'),
              SizedBox(height: 16),
              ListTile(
                leading: new MyBullet(),
                subtitle: new Text(
                    'Send unsolicited email or other communications containing links to the Information or this App'),
              ),
              ListTile(
                leading: new MyBullet(),
                subtitle: new Text(
                    'Take any action that damages or disrupts the functioning of FOREXTAINMENT\'s systems or Service'),
              ),
              ListTile(
                leading: new MyBullet(),
                subtitle: new Text(
                    'Link to any section, page, post or platform which includes material which breaches any of the above rules'),
              ),
              ListTile(

                leading: new MyBullet(),
                subtitle: new Text(
                    'Use any automated means, including without limitation, agents, robots, scripts, or spiders, to access, monitor, copy or harvest data from any part of this App'),
              ),
              ListTile(
                leading: new MyBullet(),
                subtitle: new Text(
                    'Take any action that imposes an unreasonably or disproportionately large load on the infrastructure of this App or related infrastructure'),
              ),
              SizedBox(height: 16),
              Text(
                'Risk Warning',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''Our service includes products that are traded on margin and carry a risk of losses in excess of your deposited funds. The products may not be suitable for all investors. Please ensure that you fully understand the risks involved.     '''),
              SizedBox(height: 24),
              AppButtonWidget(
                text: 'CONTINUE',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 8.0,
      width: 8.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
