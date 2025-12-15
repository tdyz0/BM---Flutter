import 'package:flutter/material.dart';

enum Cinsiyet { erkek, kadin }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  static const _bg = Color(0xFF0f172a);
  static const _card = Color(0xFF1e3a5f);
  static const _male = Color(0xFF667eea);
  static const _female = Color(0xFF764ba2);
  static const _neutral = Color(0xFF1a2847);
  static const _muted = Color(0xFF8D8E98);

  Cinsiyet? _gender;
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _age = TextEditingController();
  String? _result, _status, _advice;
  Color? _color;

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          title: const Text('Vücut Kitle İndeksi Hesaplayıcı',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          backgroundColor: _card,
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(children: [
                          _card2(
                              _gender == null
                                  ? _neutral
                                  : (_gender == Cinsiyet.erkek
                                      ? _male
                                      : _female),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                      _gender == Cinsiyet.erkek
                                          ? Icons.male
                                          : (_gender == Cinsiyet.kadin
                                              ? Icons.female
                                              : Icons.help_outline),
                                      size: 70,
                                      color: Colors.white),
                                  const SizedBox(height: 10),
                                  Text(
                                      _gender == null
                                          ? 'Cinsiyetiniz'
                                          : (_gender == Cinsiyet.erkek
                                              ? 'Erkek'
                                              : 'Kadın'),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: _muted,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ), () {
                            setState(() => _gender = _gender == Cinsiyet.erkek
                                ? Cinsiyet.kadin
                                : Cinsiyet.erkek);
                          }),
                          const SizedBox(width: 15),
                          _inputCard('Yaşınız', 'yıl', _age),
                        ]),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: Row(children: [
                          _inputCard('Boyunuz', 'cm', _height),
                          const SizedBox(width: 15),
                          _inputCard('Kilonuz', 'kg', _weight),
                        ]),
                      )),
                    ],
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: _calculate,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: _card,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 50,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: const Center(
                            child: Text('Hesapla',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_result != null)
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: Column(children: [
                  Text(_status!.toUpperCase(),
                      style: TextStyle(
                          color: _color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(_result!,
                      style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)),
                  const SizedBox(height: 10),
                  Text(_advice!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, color: _muted, height: 1.4)),
                ]),
              ),
          ],
        ),
      );

  Widget _card2(Color color, Widget child, VoidCallback? onTap) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6))
              ],
            ),
            child: child,
          ),
        ),
      );

  Widget _inputCard(String label, String suffix, TextEditingController c) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 15, color: _muted, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: c,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero),
                    ),
                  ),
                  Text(suffix,
                      style: const TextStyle(
                          fontSize: 16,
                          color: _muted,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      );

  void _calculate() {
    final h = double.tryParse(_height.text) ?? 0;
    final w = double.tryParse(_weight.text) ?? 0;
    final a = int.tryParse(_age.text) ?? 0;

    if (h <= 0 || w <= 0 || a < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Lütfen geçerli değerler girin'),
          backgroundColor: Colors.red));
      return;
    }

    final bmi = w / ((h / 100) * (h / 100));

    setState(() {
      _result = bmi.toStringAsFixed(1);
      _status = _getStatus(bmi);
      _advice = _getAdvice(bmi);
      _color = _getColor(bmi);
    });
  }

  String _getStatus(double bmi) {
    if (bmi >= 30) return 'Obezsiniz';
    if (bmi >= 25) return 'Kilolusunuz';
    if (bmi > 18.5) return 'İdeal Kilodasınız';
    return 'Zayıfsınız';
  }

  String _getAdvice(double bmi) {
    if (bmi >= 30) {
      return 'Obez sayılabilecek bir vücut ağırlığınız var. Sağlığınız için mutlaka bir doktora danışmanız ve düzenli egzersiz yapmanız önerilir.';
    }
    if (bmi >= 25) {
      return 'Normalden daha yüksek bir vücut ağırlığınız var. Spora başlamanın veya yemeği azaltmanın zamanı gelmiş olabilir.';
    }
    if (bmi > 18.5) return 'Mükemmel bir indekse sahipsiniz. Böyle devam edin.';
    return 'Normalden daha düşük bir vücut ağırlığınız var. Biraz daha fazla yemek yemeye ne dersiniz?';
  }

  Color _getColor(double bmi) {
    if (bmi >= 30) return Colors.red;
    if (bmi >= 25) return Colors.orange;
    if (bmi > 18.5) return Colors.green;
    return Colors.yellow;
  }
}
