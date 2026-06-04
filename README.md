<h1>Student Exam POC</h1>

Teknik mülakat doğrultusunda, geliştirilmiş Öğrenci, Ders ve Sınav Sonuç Yönetim uygulamasıdır.

----------------------------------------------------------------------------------------------------------------------------------------

<h2>🚀 Temel Özellikler:</h2>

- Öğrenci Yönetimi: Öğrenci ekleme, listeleme, detay görüntüleme, arama ve silme işlemleri.
- Ders Yönetimi: Ders ekleme,listeleme, güncelleme ve silme işlemleri.
- Not Yönetimi: Seçilen öğrenci ve derse özel tek tek veya toplu sınav notu girişi işlemleri.
  
----------------------------------------------------------------------------------------------------------------------------------------

<h2>🛠️ Kullanılan Teknolojiler & Mimari:</h2>

- State Management: `Provider` & `ChangeNotifier`
- Lokal Veritabanı: `sqflite`
- Dependency Injection: `get_it` 
- Navigation: `go_router`
- UI Components: Tasarlanmış atomik widget yapısı (`CustomButton`, `CustomTextField`,vs.), `Gap` ve `BuildContext` extension'ları ile esnek padding ve size yönetimi.

----------------------------------------------------------------------------------------------------------------------------------------

<h2>📂 Proje Klasör Yapısı:</h2>

Uygulama, sürdürülebilir, test edilebilir ve ölçeklenebilir olması adına **Feature-First (Özellik Odaklı)** MVVM mimarisiyle geliştirilmiştir:

```text
lib/
├── app/                 # Tek yerden kullanılan AppBar
├── components/          # Global kullanılan UI bileşenleri
├── core/                # Uygulama genelindeki servisler, uzantılar ve sabitler
│   ├── constant/
│   ├── extension/
│   ├── getIt/           # Service Locator (get_it)
│   └── service/         # DatabaseService (SQLite)
└── feature/             # MVVM Modülleri
    ├── course/          # Model, Service, ViewModel, View
    ├── results/         # Model, Service, ViewModel, View 
    └── student/         # Model, Service, ViewModel, View

```

----------------------------------------------------------------------------------------------------------------------------------------

<h2>📱 Uygulama Ekran Görüntüleri:</h2>

<table>
  <tr>
    <td>
      <p align="center"><b>Öğrenciler</b></p>
      <img src="https://github.com/user-attachments/assets/9cbac1e4-9123-4a54-86a3-9aa54a1c8cf7" width="200" alt="students" />
    </td>
    <td>
      <p align="center"><b>Öğrenci Detayı</b></p>
      <img src="https://github.com/user-attachments/assets/8615319d-270b-4609-b048-437e461a0cf5" width="200" alt="student_detail" />
    </td>
    <td>
      <p align="center"><b>Dersler</b></p>
      <img src="https://github.com/user-attachments/assets/365acd6c-e74a-42b6-a7b5-ab241d4f1f29" width="200" alt="course" />
    </td>
    <td>
      <p align="center"><b>Sonuçlar (Notlar)</b></p>
      <img src="https://github.com/user-attachments/assets/0e61ffe4-1b2b-4aa8-bef8-36c2c46eb822" width="200" alt="results" />
    </td>
  </tr>
</table>

----------------------------------------------------------------------------------------------------------------------------------------

<h2>🛠️ Kurulum ve Çalıştırma:</h2>

Projeyi yerelde çalıştırmak ve test etmek için aşağıdaki adımları sırasıyla takip edebilirsiniz:

1. Projeyi bilgisayarınıza klonlayın:
```bash
git clone https://github.com/MuhammedAliYakisik/student-exam-poc.git
cd student-exam-poc
flutter pub get
flutter run
```






