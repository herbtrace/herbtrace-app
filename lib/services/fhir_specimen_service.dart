import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4/fhir_request.dart';

import 'package:herbtrace_app/models/crop_model.dart';

class FhirSpecimenService {
  static final FhirSpecimenService _instance = FhirSpecimenService._internal();
  final String baseUrl = 'https://server.fire.ly/r4';
  factory FhirSpecimenService() {
    return _instance;
  }

  FhirSpecimenService._internal();

  Future<String?> createSpecimen(CropModel crop) async {
    try {
      final specimen = Specimen(
        status: FhirCode('available'),
        type: CodeableConcept(
          coding: [
            Coding(
              system: FhirUri('http://snomed.info/sct'),
              code: FhirCode('100000'),
              display: 'Herbal specimen',
            ),
          ],
          text: '${crop.speciesName} herbal specimen',
        ),
        subject: Reference(
          reference: 'Substance/${crop.cropId}',
          display: '${crop.speciesName} (${crop.scientificName})',
        ),
        collection: SpecimenCollection(
          collectedDateTime: FhirDateTime(DateTime.now()),
          method: CodeableConcept(
            coding: [
              Coding(
                system: FhirUri(
                  'http://terminology.hl7.org/CodeSystem/v2-0938',
                ),
                code: FhirCode('H'),
                display: 'Harvested specimen',
              ),
            ],
            text: 'Harvested specimen',
          ),
        ),
        note: [
          Annotation(
            text: FhirMarkdown(
              '${crop.speciesName} (${crop.scientificName}) specimen for analysis\n'
              'Sustainability Notes: ${crop.sustainabilityNotes}',
            ),
            time: FhirDateTime(DateTime.now()),
          ),
        ],

        processing: [
          SpecimenProcessing(
            description: crop.requiredProcessingSteps.join(', '),
            timeDateTime: FhirDateTime(DateTime.now()),
          ),
        ],
        condition: [
          CodeableConcept(
            text:
                'Quality Parameters:\n'
                'Max Moisture: ${crop.qualityParameters.maxMoisturePercent}%\n'
                'Heavy Metals Limit: ${crop.qualityParameters.heavyMetalsLimit}',
          ),
        ],
      );

      final request = FhirRequest.create(
        base: Uri.parse(baseUrl),
        resource: specimen,
      );

      final response = await request.request();

      return '${baseUrl}/Specimen/${response.fhirId}';
    } catch (e) {
      print('Error creating FHIR specimen: $e');
      return null;
    }
  }

  // Future<Specimen?> getSpecimen(String specimenUrl) async {
  //   try {
  //     final request =   FhirRequest.create(
  //   base: Uri.parse(baseUrl),
  //   resource: specimen,
  // );

  //     final response = await request.request();
  //     if (response is Specimen) {
  //       return response;
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error fetching FHIR specimen: $e');
  //     return null;
  //   }
  // }
}
