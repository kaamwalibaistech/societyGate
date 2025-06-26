import 'package:flutter/material.dart';

class SocietyPaymentsScreen extends StatelessWidget {
  const SocietyPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFFEF7FF), // light lavender shade
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFEF7FF),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Society Payments',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color(0xFF6A1B9A),
            labelColor: Color(0xFF6A1B9A),
            unselectedLabelColor: Colors.black54,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: 'Paid'),
              Tab(text: 'Unpaid'),
              Tab(text: 'Others'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PaidTab(),
            _UnpaidTab(),
            _OthersTab(),
          ],
        ),
      ),
    );
  }
}

// You can later replace this with your real data UI
class _PaidTab extends StatelessWidget {
  const _PaidTab();

  @override
  Widget build(BuildContext context) {
    return const _ComingSoon(message: 'Payment history coming soon...');
  }
}

class _UnpaidTab extends StatelessWidget {
  const _UnpaidTab();

  @override
  Widget build(BuildContext context) {
    return const _ComingSoon(message: 'Unpaid bills section coming soon...');
  }
}

class _OthersTab extends StatelessWidget {
  const _OthersTab();

  @override
  Widget build(BuildContext context) {
    return const _ComingSoon(
        message: 'Other services will be available soon...');
  }
}

class _ComingSoon extends StatelessWidget {
  final String message;
  const _ComingSoon({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
