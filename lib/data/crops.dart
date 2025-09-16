const crops = [
  {
    "resourceType": "MedicinalPlantResource",
    "id": "ayurvedic-plant-1",
    "species_common_name": "Ashwagandha",
    "species_scientific_name": "Withania somnifera",
    "approved_collection_regions": [
      {
        "region_name": "Madhya Pradesh",
        "state_name": "Madhya Pradesh",
        "latitude": 23.5,
        "longitude": 78.5,
      },
      {
        "region_name": "Rajasthan",
        "state_name": "Rajasthan",
        "latitude": 26.9,
        "longitude": 75.8,
      },
    ],
    "allowed_harvest_months": [12, 1, 2],
    "restricted_months": [6, 7, 8],
    "max_allowed_wild_collection":
        "Controlled, permits required by State Forest Dept.",
    "recommended_practice": "cultivation_and_sustainable_wild",
    "quality_parameters": {
      "max_moisture_percent": 10,
      "root_diameter_min_mm": 15,
      "withanolide_content_min_percent": 0.3,
      "pesticide_residue_limit": "As per FSSAI standards",
      "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm",
      "dna_authentication": "Required for raw drug authentication",
    },
    "processing_steps": ["Wash", "Cut", "Shade-dry", "Store", "Transport"],
    "sustainability_notes":
        "Harvest roots only after 150–180 days maturity. Leave some plants for regeneration.",
  },
  {
    "resourceType": "MedicinalPlantResource",
    "id": "ayurvedic-plant-2",
    "species_common_name": "Brahmi",
    "species_scientific_name": "Bacopa monnieri",
    "approved_collection_regions": [
      {
        "region_name": "Uttarakhand",
        "state_name": "Uttarakhand",
        "latitude": 30.2,
        "longitude": 78.2,
      },
      {
        "region_name": "Himachal Pradesh",
        "state_name": "Himachal Pradesh",
        "latitude": 32.1,
        "longitude": 77.2,
      },
    ],
    "allowed_harvest_months": [5, 6, 7, 8],
    "restricted_months": [12, 1, 2],
    "max_allowed_wild_collection":
        "Controlled, permits required by State Forest Dept.",
    "recommended_practice": "cultivation_and_sustainable_wild",
    "quality_parameters": {
      "max_moisture_percent": 12,
      "bacoside_content_min_percent": 0.5,
      "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm",
    },
    "processing_steps": ["Harvest", "Wash", "Shade-dry", "Store"],
    "sustainability_notes":
        "Ensure regeneration by leaving some plants unharvested.",
  },
  {
    "resourceType": "MedicinalPlantResource",
    "id": "ayurvedic-plant-3",
    "species_common_name": "Giloy",
    "species_scientific_name": "Tinospora cordifolia",
    "approved_collection_regions": [
      {
        "region_name": "Madhya Pradesh",
        "state_name": "Madhya Pradesh",
        "latitude": 23.2,
        "longitude": 77.4,
      },
      {
        "region_name": "Maharashtra",
        "state_name": "Maharashtra",
        "latitude": 19.7,
        "longitude": 75.3,
      },
    ],
    "allowed_harvest_months": [6, 7, 8, 9],
    "restricted_months": [10, 11, 12],
    "max_allowed_wild_collection":
        "Controlled, permits required by State Forest Dept.",
    "recommended_practice": "cultivation_and_sustainable_wild",
    "quality_parameters": {
      "max_moisture_percent": 10,
      "berberine_content_min_percent": 0.3,
      "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm",
    },
    "processing_steps": ["Collect", "Wash", "Shade-dry", "Store"],
    "sustainability_notes":
        "Harvest mature stems, leaving roots and young shoots for regeneration.",
  },
  {
    "resourceType": "MedicinalPlantResource",
    "id": "ayurvedic-plant-4",
    "species_common_name": "Tulsi",
    "species_scientific_name": "Ocimum sanctum",
    "approved_collection_regions": [
      {
        "region_name": "Uttarakhand",
        "state_name": "Uttarakhand",
        "latitude": 30.3,
        "longitude": 78.0,
      },
      {
        "region_name": "Maharashtra",
        "state_name": "Maharashtra",
        "latitude": 19.9,
        "longitude": 75.3,
      },
      {
        "region_name": "Karnataka",
        "state_name": "Karnataka",
        "latitude": 15.3,
        "longitude": 75.1,
      },
    ],
    "allowed_harvest_months": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
    "restricted_months": [],
    "max_allowed_wild_collection": "Not applicable",
    "recommended_practice": "cultivation",
    "quality_parameters": {
      "max_moisture_percent": 8,
      "essential_oil_content_min_percent": 0.5,
      "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm",
    },
    "processing_steps": ["Harvest", "Wash", "Shade-dry", "Store"],
    "sustainability_notes":
        "Regular pruning encourages new growth and prevents overharvesting.",
  },
  {
    "resourceType": "MedicinalPlantResource",
    "id": "ayurvedic-plant-5",
    "species_common_name": "Arjuna",
    "species_scientific_name": "Terminalia arjuna",
    "approved_collection_regions": [
      {
        "region_name": "Madhya Pradesh",
        "state_name": "Madhya Pradesh",
        "latitude": 23.3,
        "longitude": 77.4,
      },
      {
        "region_name": "Maharashtra",
        "state_name": "Maharashtra",
        "latitude": 19.9,
        "longitude": 75.3,
      },
    ],
    "allowed_harvest_months": [3, 4, 5, 6],
    "restricted_months": [],
    "max_allowed_wild_collection": "Not applicable",
    "recommended_practice": "cultivation",
    "quality_parameters": {
      "max_moisture_percent": 10,
      "tannins_content_min_percent": 18,
      "heavy_metals_limit": "Lead <2.5ppm, Cadmium <0.1ppm",
    },
    "processing_steps": ["Collect bark", "Wash", "Shade-dry", "Store"],
    "sustainability_notes":
        "Ensure regeneration by leaving some trees unharvested.",
  },
];
