import 'package:flutter/material.dart';

/// Width-based SizedBoxes
SizedBox sizedBoxW5(BuildContext context) =>
    SizedBox(width: MediaQuery.of(context).size.width * 0.013);
SizedBox sizedBoxW10(BuildContext context) =>
    SizedBox(width: MediaQuery.of(context).size.width * 0.025);
SizedBox sizedBoxW15(BuildContext context) =>
    SizedBox(width: MediaQuery.of(context).size.width * 0.038);
SizedBox sizedBoxW20(BuildContext context) =>
    SizedBox(width: MediaQuery.of(context).size.width * 0.05);
SizedBox sizedBoxW30(BuildContext context) =>
    SizedBox(width: MediaQuery.of(context).size.width * 0.075);

/// Height-based SizedBoxes
SizedBox sizedBoxH5(BuildContext context) =>
    SizedBox(height: MediaQuery.of(context).size.height * 0.006);
SizedBox sizedBoxH10(BuildContext context) =>
    SizedBox(height: MediaQuery.of(context).size.height * 0.012);
SizedBox sizedBoxH15(BuildContext context) =>
    SizedBox(height: MediaQuery.of(context).size.height * 0.018);
SizedBox sizedBoxH20(BuildContext context) =>
    SizedBox(height: MediaQuery.of(context).size.height * 0.025);
SizedBox sizedBoxH30(BuildContext context) =>
    SizedBox(height: MediaQuery.of(context).size.height * 0.037);
