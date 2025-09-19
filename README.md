# HerbTrace App

HerbTrace is a Flutter application designed for traceability, quality assurance, and digital record-keeping in the herbal and medicinal plant supply chain. It empowers stakeholders—such as farmers, wild collectors, processors, laboratories, manufacturers, and packers—to ensure sustainable, compliant, and transparent operations from field to finished product.

## Features

- **Multi-role Support:** Profiles for farmers, wild collectors, processors, laboratories, manufacturers, and packers, each with tailored dashboards and workflows.
- **Crop Data Management:** Detailed records for medicinal plants including origin, harvest windows, quality standards (moisture, residue, heavy metals), and recommended practices.
- **Traceability:** Track every step—collection, processing, testing, packing—using digital event logs and QR-code-based batch tracking.
- **Quality & Compliance:** Built-in quality parameter checks for FSSAI and Ayush guidelines, with support for lab testing and certification uploads.
- **Localization:** Multi-language support (including Kannada, Hindi, Sanskrit, Malayalam, Tamil).
- **Authentication & User Profiles:** OTP login and secure profile management for all user types.
- **Location Integration:** Geo-tagging and region validation for compliant collection and supply.

## Technologies Used

- **Flutter & Dart:** Modern, cross-platform mobile app development.
- **Riverpod:** Robust state management.
- **Geolocator:** For location-based services and permissions.
- **RESTful APIs:** Configurable endpoints for authentication, crop data, transactions, and profiles.
- **QR Code Integration:** For batch and event traceability.

## Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/herbtrace/herbtrace-app.git
   cd herbtrace-app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

4. **Configuration**
   - API endpoints can be modified in `lib/config/constants/api_endpoints.dart`.
   - Multilingual resources are in `lib/generated/`.

## Example Crop Data Structure

The app manages and validates crops with quality and sustainability parameters:
```dart
{
  "species_common_name": "Ashwagandha",
  "species_scientific_name": "Withania somnifera",
  "approved_collection_regions": [ ... ],
  "allowed_harvest_months": [12, 1, 2],
  "quality_parameters": {
    "max_moisture_percent": 10,
    "withanolide_content_min_percent": 0.3,
    "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm"
  },
  "processing_steps": ["Wash", "Cut", "Shade-dry", "Store", "Transport"],
  "sustainability_notes": "Harvest roots only after 150–180 days maturity. Leave some plants for regeneration."
}
```
