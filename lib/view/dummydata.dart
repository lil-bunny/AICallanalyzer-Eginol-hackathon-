import 'package:get/get.dart';

var customerObjection =
    '1. Customer is happy with current setup and not actively looking to replace it.\n2. Customer is skeptical about the product and needs proof of results, not just claims.\n3. Customer does not have time for a sales call and prefers to communicate via email.'
        .obs;
var customerSteps =
    'In the conversation, the agent offers to provide the product for free for five months for the customer to try out. If the customer gets used to it during this trial period, they can then start a subscription model. This can be considered as the next step discussed in the conversation. Additionally, the customer requests the agent to email them the details, indicating that further communication and consideration of the product will take place via email.'
        .obs;

var agentImprovement =
    " Focus on understanding the client's current setup and concerns before pitching the product\n- Provide specific examples and case studies of how the product has helped similar companies\n- Offer a free trial or demo to allow the client to experience the product firsthand\n- Be respectful of the client's time and schedule a follow-up call or email for further discussion\n- Clearly communicate the value proposition and benefits of the product in relation to the client's needs"
        .obs;

var speakerData = [
  {'speaker_type': 'A', 'speaker_text': 'Hello?'},
  {'speaker_type': 'B', 'speaker_text': 'Who is this?'},
  {
    'speaker_type': 'A',
    'speaker_text': "Hi, I am Bill Gates and I'm talking from Microsoft."
  },
  {
    'speaker_type': 'B',
    'speaker_text': 'Another sales call. Really? This better be good.'
  },
  {'speaker_type': 'A', 'speaker_text': "I don't have because listen, I have."},
  {
    'speaker_type': 'C',
    'speaker_text':
        'Built a product that will be helpful for your company and your company will be 90% more efficient than previously. So I would like to sell you my product. So can we talk?'
  },
  {
    'speaker_type': 'B',
    'speaker_text':
        "Oh great, another product that promises miracles. Look Bill, I'm not interested in buying any random product. I'm the director of sales at Agile Solutions."
  },
  {
    'speaker_type': 'C',
    'speaker_text':
        "A successful, not a random product. This product has been listed and funded by Y Combinator. So it's not a random product."
  },
  {
    'speaker_type': 'B',
    'speaker_text':
        "Y combinator or not, I really need to understand exactly how this product relates to my current concerns. Efficiency is nice to talk about, but I need results and proof, not just claims. And currently I'm very skeptical about let."
  },
  {
    'speaker_type': 'C',
    'speaker_text':
        'Me tell you about the product. This is an AI solution that helps you to audit calls in real time without using a human being. The AI can itself audit the calls and tell you what discrepancies has been occurred here. Facebook, Microsoft and Google are already using our product. So what do you say? How this product can help you.'
  },
  {
    'speaker_type': 'B',
    'speaker_text':
        "Agent that's interesting, but I'm happy with our current setup for call recording and coaching using gong. Our system works fine and we're not actively looking to replace it. Thanks for the pitch, but I really don't think this is a good fit. Please don't call me."
  },
  {
    'speaker_type': 'A',
    'speaker_text': 'Listen, we can do one thing. We can do one thing.'
  },
  {
    'speaker_type': 'C',
    'speaker_text':
        'We can give this product for free for five months in order to use. If you get used to it, then.'
  },
  {
    'speaker_type': 'A',
    'speaker_text': 'You can start any subscription model.'
  },
  {
    'speaker_type': 'B',
    'speaker_text':
        "Look, I'm actually in a meeting right now and I really don't have the time for this. If you could just email me the details and we'll take it from there. My email is jane@agilesolutions.com goodbye."
  }
].obs;

var entity_data = [
  {
    'entity_text': 'Bill Gates',
    'entity_type': 'person_name',
    'entity_start': 4548,
    'entity_end': 5130
  },
  {
    'entity_text': 'Microsoft',
    'entity_type': 'organization',
    'entity_start': 6612,
    'entity_end': 7550
  },
  {
    'entity_text': 'Bill',
    'entity_type': 'person_name',
    'entity_start': 33772,
    'entity_end': 33974
  },
  {
    'entity_text': 'director of sales',
    'entity_type': 'occupation',
    'entity_start': 36668,
    'entity_end': 37302
  },
  {
    'entity_text': 'Agile Solutions',
    'entity_type': 'organization',
    'entity_start': 37564,
    'entity_end': 38646
  },
  {
    'entity_text': 'Y Combinator',
    'entity_type': 'organization',
    'entity_start': 43392,
    'entity_end': 44214
  },
  {
    'entity_text': 'Facebook',
    'entity_type': 'organization',
    'entity_start': 76076,
    'entity_end': 76594
  },
  {
    'entity_text': 'Microsoft',
    'entity_type': 'organization',
    'entity_start': 76642,
    'entity_end': 77186
  },
  {
    'entity_text': 'Google',
    'entity_type': 'organization',
    'entity_start': 77388,
    'entity_end': 77670
  },
  {
    'entity_text': 'Agent',
    'entity_type': 'occupation',
    'entity_start': 84250,
    'entity_end': 85046
  },
  {
    'entity_text': 'jane@agilesolutions.com',
    'entity_type': 'email_address',
    'entity_start': 119348,
    'entity_end': 120990
  }
].obs;

List<Map<String, dynamic>> filterAndCombineDuplicates(
    List<Map<String, dynamic>> entityData) {
  var entityMap = <String, String>{};

  for (var entity in entityData) {
    var entityType = entity['entity_type'];
    var entityText = entity['entity_text'];

    if (!entityMap.containsKey(entityType)) {
      entityMap[entityType] = entityText;
    } else {
      entityMap[entityType] = entityMap[entityType]! + ', $entityText';
    }
  }

  var filteredEntityData = <Map<String, dynamic>>[];

  for (var entry in entityMap.entries) {
    filteredEntityData.add({
      'entity_text': entry.value,
      'entity_type': entry.key,
    });
  }

  return filteredEntityData;
}
