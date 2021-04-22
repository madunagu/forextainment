import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:forextainment/widgets/AppButtonWidget.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key key}) : super(key: key);

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
                'POLICY STATEMENT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                  '''By opening a FOREXTAINMENT account, you give your consent to the collection and use of personal information by FOREXTAINMENT as explained in this Privacy Statement.
                      '''),
              Text(
                'How do we use the personal information?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'To verify your identity and establish and manage your account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''As part of providing services, or information about our services, to you, we will need to verify your identity to set you up as a customer and we will need to use those details in order to effectively manage your account with us to ensure that you are getting the best possible service from us. This may include third parties carrying out credit or identity checks on our behalf. It is not only in our legitimate interest to do so but the use of your personal information in this way is necessary for us to know who you are as we have a legal obligation to comply with certain Know Your Customer regulatory obligations.
      '''),
              Text(
                'To provide you with products and services, or information about our products and services, and to review your ongoing needs',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''Once you open an account with us, or subscribe to an update or webinar, we will need to use your personal information to perform our services and comply with our obligations to you. It is also in our legitimate interests to ensure that we are providing the best products and services so we may periodically review your needs to ensure that you are getting the benefit of the best possible products and services from us.   
                   '''),
              Text(
                'To help us improve our products and services, including customer services, and develop and market new products and services',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may from time to time use personal information provided by you through your use of the services and/or through customer surveys to help us improve our products and services. It is in our legitimate interests for us to use your personal information in this way to ensure that we provide you with the best products and services we can and to continue to be a market leader in our industry.
                    '''),
              Text(
                'To form a profile about you',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may from time to time use personal information about you to form profiles about you so that we can understand you and provide the very best products and services we can. We may also make decisions about you through automated profiling or automated credit checks which may affect your ability to use our services. We may need to do this either to perform our legal obligations or because it is in our legitimate interest to use your personal information in such a way.
    '''),
              Text(
                'To investigate or settle enquiries or disputes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may need to use personal information collected from you to investigate issues and/or settle disputes with you as it is in our legitimate interests to ensure that issues and/or disputes get investigated and resolved as quickly and efficiently as possible.
   '''),
              Text(
                'To comply with applicable law, court order, other judicial process, or the requirements of any applicable regulatory authorities',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may need to use your personal information to comply with applicable law, court order or other judicial process, or the requirements of any applicable regulatory authority. We do this not only to comply with our legal obligations but because it may also be in our legitimate interest to do so.     
                   '''),
              Text(
                'To provide references about you',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''From time to time, third parties, such as credit agencies may approach us to provide a credit reference about you for credit and identity checks. It may be in our legitimate interest to comply with our legal obligations or we may be obliged to provide such a reference in order to comply with a legal obligation. However, if we are unsure, we will speak to you first before providing any reference.
 '''),
              Text(
                'To send you surveys',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''From time to time, we may send you surveys as part of our customer feedback process and it is in our legitimate interest to ask for feedback to ensure that we provide the best service to you. However, we may from time to time also ask you to participate in other surveys and if you agree to participate in such surveys, we rely on your consent to use the personal information we collect as part of such survey. All responses to any survey we send out whether for customer feedback or otherwise will be aggregated and depersonalized before survey results are shared with any third parties.
  '''),
              Text(
                'Data analysis',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''Our web pages and e-mails may contain web beacons or pixel tags or any other similar type of data analysis tools which allow us to track receipt of correspondence and to count the number of users that have visited our webpage or opened our correspondence. Where your personal information is completely anonymized, we do not require a legal basis as the information will no longer constitute personal information. However, where your personal information is not in an anonymized form, it is in our legitimate interest to continually evaluate that personal information to ensure that the products and services we provide are relevant to the market.
   '''),
              Text(
                'Marketing by us',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may use your personal information to send you marketing communications by email or phone or other agreed forms (including social media campaigns) to ensure that you are always kept up to date with our latest products and services. Where we send you marketing communications, we will either do so as it is in our legitimate interest or with your consent. 
                  '''),
              Text(
                'Internal business purposes and record keeping',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''We may need to process your personal information for internal business and research purposes and record keeping purposes. Such processing is in our own legitimate interests and is required in order to comply with our legal obligations. This may include any communications that we have with you in relation to the services we provide to you and our relationship with you. We will also keep records to ensure that you comply with your obligations under any contract you have entered into with us.
 '''),
              Text(
                'Corporate restructuring',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''If we undergo a corporate restructure or part or all of our business is acquired by a third party, we may need to use your personal information in association with that restructure or acquisition. Such use may involve disclosing your details as part of a due diligence exercise. It is our legitimate interest to use your information in this way provided we comply with any legal obligation we have to you.
                   '''),
              Text(
                'Access',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''If you ask us, we will confirm whether we are processing your personal information and, if so, provide you with a copy of that personal information (along with certain other details). If you require additional copies, we may need to charge a reasonable administration fee.      
                  '''),
              Text(
                'Rectification',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('''
If the personal information we hold about you is inaccurate or incomplete, you are entitled to have it rectified. If we have shared your personal information with others, we will let them know about the rectification where possible. If you ask us, where possible and lawful to do so, we will also tell you who we have shared your personal information with so that you can contact them directly.
  '''),
              Text(
                'Erasure',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''You can ask us to delete or remove your personal information in certain circumstances such as where we no longer need it or you withdraw your consent (where applicable) provided that we have no legal obligation to retain that data. Such request will be subject to any retention limits we are required to comply with in accordance with applicable laws and regulations and subject to section 'How do we store personal information and for how long'. If we have shared your personal information with others, we will let them know about the erasure where possible. If you ask us, where possible and lawful to do so, we will also tell you who we have shared your personal information with so that you can contact them directly.
   '''),
              Text(
                'Processing restrictions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''You can ask us to ‘block’ or suppress the processing of your personal information in certain circumstances such as where you contest the accuracy of that personal information or object to us processing it. It will not stop us from storing your personal information though. We will tell you before we lift any restriction. If we have shared your personal information with others, we will let them know about the restriction where possible. If you ask us, where possible and lawful to do so, we will also tell you who we have shared your personal information with so that you can contact them directly.  
                   '''),
              Text(
                'Objection',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''You can ask us to stop processing your personal information, and we will do so, if we are:
relying on our own or someone else’s legitimate interests to process your personal information except if we can demonstrate compelling legal grounds for the processing;
processing your personal information for direct marketing; or processing your personal information for research unless such processing is necessary for the performance of a task carried out in the public interest.
   '''),
              Text(
                'Automated decision-making and profiling',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                  '''If we have made a decision about you based solely on an automated process (e.g., through automatic profiling) that affects your ability to use the services or has another significant effect on you, you can ask to not to be subject to such a decision unless we can demonstrate to you that such decision is necessary for entering into, or the performance of, a contract between you and us. Even where a decision is necessary for entering into or performing a contract, you may contest the decision and require human intervention. '''),
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
