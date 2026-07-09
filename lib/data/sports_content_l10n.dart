import 'package:flutter/widgets.dart';

import 'sports_data.dart';

/// Bir sporun yalnızca metinsel (yerelleştirilebilir) içeriği: ad, kısa cümle
/// ve bölümler. Yapısal alanlar (id/icon/color/videoUrl) [Sport] içinde kalır.
///
/// ÖNEMLİ: Spor adı ([Sport.name]) aynı zamanda branş dropdown'unun sakladığı
/// Türkçe anahtardır; burada yalnızca GÖSTERİM için çevrilir. Öğrenci/antrenör
/// kayıtlarındaki `branch` değeri Türkçe kalır.
class SportContent {
  final String name;
  final String tagline;
  final List<SportSection> sections;

  const SportContent({
    required this.name,
    required this.tagline,
    required this.sections,
  });
}

/// Verilen spor için geçerli dile göre gösterim içeriği. Çeviri yoksa (ör.
/// Türkçe ya da eksik bir dil) [Sport] içindeki Türkçe içerik döner.
SportContent localizedSportContent(Sport sport, Locale locale) {
  final byId = _contentByLocale[locale.languageCode];
  final content = byId?[sport.id];
  if (content != null) {
    return content;
  }
  return SportContent(
    name: sport.name,
    tagline: sport.tagline,
    sections: sport.sections,
  );
}

// --- Çeviriler ---------------------------------------------------------------
// Türkçe içerik sports_data.dart'ta (varsayılan/fallback). Aşağıda en/es/ru/fr.
// NOT: Makine çevirisidir; nihai metinler gözden geçirilmeli.

const Map<String, Map<String, SportContent>> _contentByLocale = {
  'en': _en,
  'es': _es,
  'ru': _ru,
  'fr': _fr,
  'ar': _ar,
};

// ============================ ENGLISH =======================================
const Map<String, SportContent> _en = {
  'futbol': SportContent(
    name: 'Football',
    tagline: 'Teamwork, coordination and endurance',
    sections: [
      SportSection(title: 'Description', items: [
        'Football is a team sport based on foot skill, where two teams try to '
            'score by sending the ball into the opponent\'s goal.',
        'Each team has 11 players including the goalkeeper, and a match '
            'consists of two halves.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Improves cardiovascular health and endurance.',
        'Teaches teamwork, communication and sharing.',
        'Builds balance, coordination and agility.',
      ]),
      SportSection(title: 'Basics', items: [
        'The ball is not played with the hands (except the goalkeeper in the '
            'penalty area).',
        'The aim is to score by putting the ball into the opponent\'s goal.',
        'Fair play and respect for the opponent are essential.',
      ]),
    ],
  ),
  'basketbol': SportContent(
    name: 'Basketball',
    tagline: 'Speed, jumping and hand-eye coordination',
    sections: [
      SportSection(title: 'Description', items: [
        'Basketball is a sport played by two teams of five, where you try to '
            'score by throwing the ball into the opponent\'s hoop.',
        'The ball is advanced by dribbling or passing.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Improves jumping power and reflexes.',
        'Enhances hand-eye coordination.',
        'Strengthens quick decision-making and teamwork.',
      ]),
      SportSection(title: 'Basics', items: [
        'No double dribble or travelling (fouls) while dribbling.',
        'Baskets are worth 1, 2 or 3 points depending on shot distance.',
        'Balance between defense and offense is important.',
      ]),
    ],
  ),
  'voleybol': SportContent(
    name: 'Volleyball',
    tagline: 'Team harmony, timing and jumping',
    sections: [
      SportSection(title: 'Description', items: [
        'Volleyball is a sport where two teams separated by a net try to send '
            'the ball into the opposing court without letting it drop.',
        'Each team sends the ball over with at most three touches.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Improves reflexes and timing skills.',
        'Strengthens communication and harmony within the team.',
        'Works the upper body and leg muscles.',
      ]),
      SportSection(title: 'Basics', items: [
        'The same player cannot touch the ball twice in a row.',
        'Bump, set and spike are the basic techniques.',
        'Points are won by landing the ball in the opposing court.',
      ]),
    ],
  ),
  'yuzme': SportContent(
    name: 'Swimming',
    tagline: 'A safe sport that works the whole body',
    sections: [
      SportSection(title: 'Description', items: [
        'Swimming is an individual sport based on moving through water with '
            'various techniques (freestyle, breaststroke, backstroke, '
            'butterfly).',
        'It is important both as a competition and as a life skill.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Works all body muscles without straining the joints.',
        'Improves lung capacity and endurance.',
        'Builds water safety and self-confidence.',
      ]),
      SportSection(title: 'Basics', items: [
        'Correct breathing technique is the foundation of swimming.',
        'Warm-up and supervision are essential for safety.',
        'Different styles work different muscle groups.',
      ]),
    ],
  ),
  'tenis': SportContent(
    name: 'Tennis',
    tagline: 'Focus, agility and hand skill',
    sections: [
      SportSection(title: 'Description', items: [
        'Tennis is a sport played singles or doubles, based on sending the '
            'ball over the net into the opponent\'s court with a racket.',
        'The aim is to land the ball where the opponent cannot return it.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Improves agility, balance and hand-eye coordination.',
        'Enhances focus and strategy-building skills.',
        'Works the whole body in a balanced way.',
      ]),
      SportSection(title: 'Basics', items: [
        'The ball may be hit after bouncing once.',
        'Serve, forehand and backhand are the basic strokes.',
        'The scoring system goes 15-30-40.',
      ]),
    ],
  ),
  'jimnastik': SportContent(
    name: 'Gymnastics',
    tagline: 'Flexibility, balance and body control',
    sections: [
      SportSection(title: 'Description', items: [
        'Gymnastics is a sport where movements requiring flexibility, balance '
            'and strength are performed with mastery.',
        'It has different disciplines such as floor, balance beam and vault.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops flexibility and body control to a high level.',
        'Improves balance, posture and muscle strength.',
        'Builds discipline and self-confidence.',
      ]),
      SportSection(title: 'Basics', items: [
        'Warm-up and stretching are critical to prevent injury.',
        'Movements are learned gradually and under supervision.',
        'Correct technique is the foundation of safety.',
      ]),
    ],
  ),
  'karate': SportContent(
    name: 'Karate',
    tagline: 'Discipline, balance and self-defense',
    sections: [
      SportSection(title: 'Description', items: [
        'Karate is a Far Eastern martial art based on hand and foot '
            'techniques.',
        'It has two main parts: kata (movement sequences) and kumite (paired '
            'practice).',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops discipline, self-control and respect.',
        'Strengthens balance, coordination and reflexes.',
        'Builds self-confidence and self-defense skills.',
      ]),
      SportSection(title: 'Basics', items: [
        'The belt system shows progress.',
        'Warm-up and correct technique prevent injury.',
        'Controlled and respectful practice is essential.',
      ]),
    ],
  ),
  'taekwondo': SportContent(
    name: 'Taekwondo',
    tagline: 'Kicking techniques, flexibility and discipline',
    sections: [
      SportSection(title: 'Description', items: [
        'Taekwondo is a martial art of Korean origin in which kicking '
            'techniques stand out in particular.',
        'It is common both as a sport and as self-defense, and is an Olympic '
            'discipline.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Increases leg flexibility and strength.',
        'Develops balance, agility and reflexes.',
        'Builds discipline and self-confidence.',
      ]),
      SportSection(title: 'Basics', items: [
        'Level progresses with the belt system.',
        'Warm-up and stretching are very important.',
        'Controlled technique and respect are essential.',
      ]),
    ],
  ),
  'judo': SportContent(
    name: 'Judo',
    tagline: 'Balance, grip and takedowns',
    sections: [
      SportSection(title: 'Description', items: [
        'Judo is a martial art of Japanese origin based on unbalancing and '
            'controlling the opponent.',
        'Instead of strikes, it uses grips, throws and ground techniques.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops balance, grip strength and body control.',
        'Teaches safe falling through breakfall (ukemi) techniques.',
        'Builds discipline, respect and self-confidence.',
      ]),
      SportSection(title: 'Basics', items: [
        'It is practiced on a mat; safe falling is fundamental.',
        'Progress is made with the belt system.',
        'Respect and control toward the opponent are essential.',
      ]),
    ],
  ),
  'atletizm': SportContent(
    name: 'Athletics',
    tagline: 'The foundation of running, jumping and throwing',
    sections: [
      SportSection(title: 'Description', items: [
        'Athletics is a sport known as the "mother of sports", covering '
            'running, jumping and throwing disciplines.',
        'It has many branches such as short/long distance running, long jump '
            'and shot put.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops endurance, speed and strength in a balanced way.',
        'Strengthens all basic movement skills.',
        'Builds individual goal-setting and discipline.',
      ]),
      SportSection(title: 'Basics', items: [
        'Warm-up and running technique prevent injury.',
        'Each branch has its own technique.',
        'Progress is tracked with measurable goals.',
      ]),
    ],
  ),
  'masa-tenisi': SportContent(
    name: 'Table Tennis',
    tagline: 'Reflexes, speed and concentration',
    sections: [
      SportSection(title: 'Description', items: [
        'Table tennis is a fast sport based on hitting a small ball back and '
            'forth with a paddle on a table.',
        'It is played singles or doubles and requires very fast reactions.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops hand-eye coordination and reflexes to a high level.',
        'Strengthens concentration and quick decision-making.',
        'A sport that can be played at any age with low injury risk.',
      ]),
      SportSection(title: 'Basics', items: [
        'Serve and stroke techniques are fundamental.',
        'The ball must bounce once on the table.',
        'Quick footwork is important.',
      ]),
    ],
  ),
  'satranc': SportContent(
    name: 'Chess',
    tagline: 'Strategy, attention and planning',
    sections: [
      SportSection(title: 'Description', items: [
        'Chess is a mind sport in which two players engage in a strategic '
            'battle with pieces on a 64-square board.',
        'The aim is to checkmate the opponent\'s king.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops analytical thinking and planning skills.',
        'Improves attention, patience and concentration.',
        'Strengthens problem-solving and foresight.',
      ]),
      SportSection(title: 'Basics', items: [
        'Each piece has its own way of moving.',
        'The game consists of opening, middlegame and endgame.',
        'It builds patience and forward planning.',
      ]),
    ],
  ),
  'hentbol': SportContent(
    name: 'Handball',
    tagline: 'Speed, passing and teamwork',
    sections: [
      SportSection(title: 'Description', items: [
        'Handball is a sport played by two teams of seven, based on passing '
            'the ball by hand and scoring in the opponent\'s goal.',
        'It involves fast attack and defense transitions.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops speed, jumping and throwing power.',
        'Strengthens teamwork and quick decision-making.',
        'Improves whole-body coordination.',
      ]),
      SportSection(title: 'Basics', items: [
        'The ball is played by hand; the goalkeeper\'s area is not entered.',
        'The ball can be carried at most three steps in hand.',
        'Passing and positioning are important.',
      ]),
    ],
  ),
  'badminton': SportContent(
    name: 'Badminton',
    tagline: 'Agility, reflexes and timing',
    sections: [
      SportSection(title: 'Description', items: [
        'Badminton is a racket sport based on sending a shuttlecock over the '
            'net into the opponent\'s court with a racket.',
        'It is played singles or doubles and involves quick changes of '
            'direction.',
      ]),
      SportSection(title: 'Benefits', items: [
        'Develops agility, reflexes and endurance.',
        'Enhances hand-eye coordination.',
        'Works the whole body in a balanced way.',
      ]),
      SportSection(title: 'Basics', items: [
        'The shuttlecock is hit before it touches the ground.',
        'Serve and smash are the basic techniques.',
        'Quick footwork is decisive.',
      ]),
    ],
  ),
};

// ============================ SPANISH =======================================
const Map<String, SportContent> _es = {
  'futbol': SportContent(
    name: 'Fútbol',
    tagline: 'Trabajo en equipo, coordinación y resistencia',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El fútbol es un deporte de equipo basado en la habilidad con los '
            'pies, donde dos equipos intentan marcar enviando el balón a la '
            'portería rival.',
        'Cada equipo está formado por 11 jugadores incluido el portero, y un '
            'partido consta de dos tiempos.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Mejora la salud cardiovascular y la resistencia.',
        'Enseña trabajo en equipo, comunicación y a compartir.',
        'Aporta equilibrio, coordinación y agilidad.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El balón no se juega con las manos (salvo el portero dentro del '
            'área).',
        'El objetivo es marcar metiendo el balón en la portería rival.',
        'El juego limpio y el respeto al rival son esenciales.',
      ]),
    ],
  ),
  'basketbol': SportContent(
    name: 'Baloncesto',
    tagline: 'Velocidad, salto y coordinación ojo-mano',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El baloncesto es un deporte que juegan dos equipos de cinco, donde se '
            'intenta anotar lanzando el balón al aro rival.',
        'El balón se avanza botando (dribbling) o pasando.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Mejora la potencia de salto y los reflejos.',
        'Aumenta la coordinación ojo-mano.',
        'Fortalece la toma de decisiones rápida y el juego en equipo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'No se hacen dobles ni pasos (faltas) al botar.',
        'Las canastas valen 1, 2 o 3 puntos según la distancia de tiro.',
        'El equilibrio entre defensa y ataque es importante.',
      ]),
    ],
  ),
  'voleybol': SportContent(
    name: 'Voleibol',
    tagline: 'Armonía de equipo, sincronización y salto',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El voleibol es un deporte donde dos equipos separados por una red '
            'intentan enviar el balón al campo contrario sin dejarlo caer.',
        'Cada equipo pasa el balón con un máximo de tres toques.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Mejora los reflejos y la sincronización.',
        'Fortalece la comunicación y la armonía dentro del equipo.',
        'Trabaja los músculos del tren superior y las piernas.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El mismo jugador no puede tocar el balón dos veces seguidas.',
        'El toque de antebrazo, el pase y el remate son técnicas básicas.',
        'Los puntos se ganan haciendo caer el balón en el campo rival.',
      ]),
    ],
  ),
  'yuzme': SportContent(
    name: 'Natación',
    tagline: 'Un deporte seguro que trabaja todo el cuerpo',
    sections: [
      SportSection(title: 'Descripción', items: [
        'La natación es un deporte individual basado en avanzar por el agua '
            'con distintas técnicas (libre, braza, espalda, mariposa).',
        'Es importante tanto como competición como habilidad para la vida.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Trabaja todos los músculos sin forzar las articulaciones.',
        'Mejora la capacidad pulmonar y la resistencia.',
        'Aporta seguridad en el agua y confianza en uno mismo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'La técnica de respiración correcta es la base de la natación.',
        'El calentamiento y la supervisión son imprescindibles por seguridad.',
        'Los distintos estilos trabajan distintos grupos musculares.',
      ]),
    ],
  ),
  'tenis': SportContent(
    name: 'Tenis',
    tagline: 'Concentración, agilidad y habilidad manual',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El tenis es un deporte que se juega individual o en dobles, basado en '
            'enviar la pelota por encima de la red al campo rival con una '
            'raqueta.',
        'El objetivo es hacer caer la pelota donde el rival no pueda '
            'devolverla.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Mejora la agilidad, el equilibrio y la coordinación ojo-mano.',
        'Aumenta la concentración y la capacidad de crear estrategias.',
        'Trabaja todo el cuerpo de forma equilibrada.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'La pelota puede golpearse tras botar una vez.',
        'El saque, el golpe de derecha y el revés son los golpes básicos.',
        'El sistema de puntos avanza 15-30-40.',
      ]),
    ],
  ),
  'jimnastik': SportContent(
    name: 'Gimnasia',
    tagline: 'Flexibilidad, equilibrio y control corporal',
    sections: [
      SportSection(title: 'Descripción', items: [
        'La gimnasia es un deporte en el que se ejecutan con maestría '
            'movimientos que requieren flexibilidad, equilibrio y fuerza.',
        'Tiene distintas disciplinas como suelo, barra de equilibrio y salto.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la flexibilidad y el control corporal a un alto nivel.',
        'Mejora el equilibrio, la postura y la fuerza muscular.',
        'Aporta disciplina y confianza en uno mismo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El calentamiento y los estiramientos son críticos para evitar '
            'lesiones.',
        'Los movimientos se aprenden de forma gradual y con supervisión.',
        'La técnica correcta es la base de la seguridad.',
      ]),
    ],
  ),
  'karate': SportContent(
    name: 'Kárate',
    tagline: 'Disciplina, equilibrio y defensa personal',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El kárate es un arte marcial de Extremo Oriente basado en técnicas de '
            'manos y pies.',
        'Tiene dos partes principales: kata (secuencias de movimientos) y '
            'kumite (práctica en pareja).',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la disciplina, el autocontrol y el respeto.',
        'Fortalece el equilibrio, la coordinación y los reflejos.',
        'Aporta confianza en uno mismo y capacidad de defensa personal.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El sistema de cinturones muestra el progreso.',
        'El calentamiento y la técnica correcta evitan lesiones.',
        'La práctica controlada y respetuosa es esencial.',
      ]),
    ],
  ),
  'taekwondo': SportContent(
    name: 'Taekwondo',
    tagline: 'Técnicas de patada, flexibilidad y disciplina',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El taekwondo es un arte marcial de origen coreano en el que destacan '
            'especialmente las técnicas de patada.',
        'Es común tanto como deporte como defensa personal, y es una '
            'disciplina olímpica.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Aumenta la flexibilidad y la fuerza de las piernas.',
        'Desarrolla el equilibrio, la agilidad y los reflejos.',
        'Aporta disciplina y confianza en uno mismo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El nivel avanza con el sistema de cinturones.',
        'El calentamiento y los estiramientos son muy importantes.',
        'La técnica controlada y el respeto son esenciales.',
      ]),
    ],
  ),
  'judo': SportContent(
    name: 'Judo',
    tagline: 'Equilibrio, agarre y derribos',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El judo es un arte marcial de origen japonés basado en desequilibrar '
            'y controlar al oponente.',
        'En lugar de golpes, usa agarres, proyecciones y técnicas de suelo.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla el equilibrio, la fuerza de agarre y el control corporal.',
        'Enseña a caer de forma segura con técnicas de caída (ukemi).',
        'Aporta disciplina, respeto y confianza en uno mismo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'Se practica sobre tatami; la caída segura es fundamental.',
        'Se progresa con el sistema de cinturones.',
        'El respeto y el control hacia el rival son esenciales.',
      ]),
    ],
  ),
  'atletizm': SportContent(
    name: 'Atletismo',
    tagline: 'La base de correr, saltar y lanzar',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El atletismo es un deporte conocido como la "madre de los deportes", '
            'que abarca las disciplinas de carrera, salto y lanzamiento.',
        'Tiene muchas modalidades como carreras de corta/larga distancia, '
            'salto de longitud y lanzamiento de peso.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la resistencia, la velocidad y la fuerza de forma '
            'equilibrada.',
        'Fortalece todas las habilidades motrices básicas.',
        'Aporta el hábito de fijarse metas individuales y disciplina.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El calentamiento y la técnica de carrera evitan lesiones.',
        'Cada modalidad tiene su propia técnica.',
        'El progreso se sigue con metas medibles.',
      ]),
    ],
  ),
  'masa-tenisi': SportContent(
    name: 'Tenis de mesa',
    tagline: 'Reflejos, velocidad y concentración',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El tenis de mesa es un deporte rápido basado en golpear una pequeña '
            'pelota de un lado a otro con una pala sobre una mesa.',
        'Se juega individual o en dobles y requiere reacciones muy rápidas.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la coordinación ojo-mano y los reflejos a un alto nivel.',
        'Fortalece la concentración y la toma de decisiones rápida.',
        'Un deporte que se puede jugar a cualquier edad con bajo riesgo de '
            'lesión.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El saque y las técnicas de golpeo son fundamentales.',
        'La pelota debe botar una vez en la mesa.',
        'El juego de pies rápido es importante.',
      ]),
    ],
  ),
  'satranc': SportContent(
    name: 'Ajedrez',
    tagline: 'Estrategia, atención y planificación',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El ajedrez es un deporte mental en el que dos jugadores libran una '
            'batalla estratégica con piezas en un tablero de 64 casillas.',
        'El objetivo es dar jaque mate al rey del rival.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla el pensamiento analítico y la planificación.',
        'Mejora la atención, la paciencia y la concentración.',
        'Fortalece la resolución de problemas y la previsión.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'Cada pieza tiene su propia forma de moverse.',
        'La partida consta de apertura, medio juego y final.',
        'Aporta paciencia y planificación anticipada.',
      ]),
    ],
  ),
  'hentbol': SportContent(
    name: 'Balonmano',
    tagline: 'Velocidad, pases y juego en equipo',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El balonmano es un deporte que juegan dos equipos de siete, basado en '
            'pasar el balón con la mano y marcar en la portería rival.',
        'Incluye rápidas transiciones de ataque y defensa.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la velocidad, el salto y la potencia de lanzamiento.',
        'Fortalece el juego en equipo y la toma de decisiones rápida.',
        'Mejora la coordinación de todo el cuerpo.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El balón se juega con la mano; no se entra en el área del portero.',
        'El balón puede llevarse en la mano un máximo de tres pasos.',
        'El pase y la colocación son importantes.',
      ]),
    ],
  ),
  'badminton': SportContent(
    name: 'Bádminton',
    tagline: 'Agilidad, reflejos y sincronización',
    sections: [
      SportSection(title: 'Descripción', items: [
        'El bádminton es un deporte de raqueta basado en enviar un volante por '
            'encima de la red al campo rival con una raqueta.',
        'Se juega individual o en dobles e incluye rápidos cambios de '
            'dirección.',
      ]),
      SportSection(title: 'Beneficios', items: [
        'Desarrolla la agilidad, los reflejos y la resistencia.',
        'Aumenta la coordinación ojo-mano.',
        'Trabaja todo el cuerpo de forma equilibrada.',
      ]),
      SportSection(title: 'Conceptos básicos', items: [
        'El volante se golpea antes de que toque el suelo.',
        'El saque y el remate son las técnicas básicas.',
        'El juego de pies rápido es decisivo.',
      ]),
    ],
  ),
};

// ============================ RUSSIAN =======================================
const Map<String, SportContent> _ru = {
  'futbol': SportContent(
    name: 'Футбол',
    tagline: 'Командная игра, координация и выносливость',
    sections: [
      SportSection(title: 'Описание', items: [
        'Футбол — командный вид спорта, основанный на работе ногами, где две '
            'команды стараются забить, отправив мяч в ворота соперника.',
        'Каждая команда состоит из 11 игроков, включая вратаря, а матч состоит '
            'из двух таймов.',
      ]),
      SportSection(title: 'Польза', items: [
        'Улучшает здоровье сердечно-сосудистой системы и выносливость.',
        'Учит командной работе, общению и умению делиться.',
        'Развивает равновесие, координацию и ловкость.',
      ]),
      SportSection(title: 'Основы', items: [
        'Мяч нельзя играть руками (кроме вратаря в штрафной площади).',
        'Цель — забить гол, отправив мяч в ворота соперника.',
        'Честная игра и уважение к сопернику обязательны.',
      ]),
    ],
  ),
  'basketbol': SportContent(
    name: 'Баскетбол',
    tagline: 'Скорость, прыжок и координация «глаз-рука»',
    sections: [
      SportSection(title: 'Описание', items: [
        'Баскетбол — вид спорта, в который играют две команды по пять человек, '
            'где стараются набрать очки, забрасывая мяч в кольцо соперника.',
        'Мяч продвигают ведением (дриблингом) или передачами.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает прыгучесть и реакцию.',
        'Улучшает координацию «глаз-рука».',
        'Укрепляет быстрое принятие решений и командную игру.',
      ]),
      SportSection(title: 'Основы', items: [
        'При ведении нельзя делать двойное ведение или пробежку (нарушения).',
        'Броски приносят 1, 2 или 3 очка в зависимости от дистанции.',
        'Важен баланс между защитой и нападением.',
      ]),
    ],
  ),
  'voleybol': SportContent(
    name: 'Волейбол',
    tagline: 'Слаженность команды, тайминг и прыжок',
    sections: [
      SportSection(title: 'Описание', items: [
        'Волейбол — вид спорта, где две команды, разделённые сеткой, стараются '
            'отправить мяч на сторону соперника, не дав ему упасть.',
        'Каждая команда переводит мяч максимум за три касания.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает реакцию и чувство тайминга.',
        'Укрепляет общение и слаженность внутри команды.',
        'Задействует мышцы верхней части тела и ног.',
      ]),
      SportSection(title: 'Основы', items: [
        'Один и тот же игрок не может касаться мяча два раза подряд.',
        'Приём, передача и нападающий удар — базовые техники.',
        'Очки набирают, приземляя мяч на стороне соперника.',
      ]),
    ],
  ),
  'yuzme': SportContent(
    name: 'Плавание',
    tagline: 'Безопасный спорт для всего тела',
    sections: [
      SportSection(title: 'Описание', items: [
        'Плавание — индивидуальный вид спорта, основанный на передвижении в '
            'воде различными техниками (кроль, брасс, на спине, баттерфляй).',
        'Оно важно и как соревнование, и как жизненный навык.',
      ]),
      SportSection(title: 'Польза', items: [
        'Задействует все мышцы тела, не нагружая суставы.',
        'Улучшает объём лёгких и выносливость.',
        'Даёт навык безопасности на воде и уверенность в себе.',
      ]),
      SportSection(title: 'Основы', items: [
        'Правильная техника дыхания — основа плавания.',
        'Разминка и присмотр обязательны для безопасности.',
        'Разные стили задействуют разные группы мышц.',
      ]),
    ],
  ),
  'tenis': SportContent(
    name: 'Теннис',
    tagline: 'Концентрация, ловкость и мастерство руки',
    sections: [
      SportSection(title: 'Описание', items: [
        'Теннис — вид спорта, в который играют один на один или парами, '
            'основанный на отправке мяча через сетку на сторону соперника '
            'ракеткой.',
        'Цель — приземлить мяч там, где соперник не сможет его отбить.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает ловкость, равновесие и координацию «глаз-рука».',
        'Повышает концентрацию и умение выстраивать стратегию.',
        'Гармонично задействует всё тело.',
      ]),
      SportSection(title: 'Основы', items: [
        'По мячу можно бить после одного отскока.',
        'Подача, форхенд и бэкхенд — базовые удары.',
        'Система счёта идёт 15-30-40.',
      ]),
    ],
  ),
  'jimnastik': SportContent(
    name: 'Гимнастика',
    tagline: 'Гибкость, равновесие и контроль тела',
    sections: [
      SportSection(title: 'Описание', items: [
        'Гимнастика — вид спорта, в котором с мастерством выполняются '
            'движения, требующие гибкости, равновесия и силы.',
        'В ней есть разные дисциплины: вольные упражнения, бревно и опорный '
            'прыжок.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает гибкость и контроль тела на высоком уровне.',
        'Улучшает равновесие, осанку и мышечную силу.',
        'Прививает дисциплину и уверенность в себе.',
      ]),
      SportSection(title: 'Основы', items: [
        'Разминка и растяжка критически важны для профилактики травм.',
        'Движения осваиваются постепенно и под присмотром.',
        'Правильная техника — основа безопасности.',
      ]),
    ],
  ),
  'karate': SportContent(
    name: 'Карате',
    tagline: 'Дисциплина, равновесие и самооборона',
    sections: [
      SportSection(title: 'Описание', items: [
        'Карате — дальневосточное боевое искусство, основанное на технике рук '
            'и ног.',
        'В нём две основные части: ката (последовательности движений) и кумите '
            '(парная работа).',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает дисциплину, самоконтроль и уважение.',
        'Укрепляет равновесие, координацию и реакцию.',
        'Даёт уверенность в себе и навык самообороны.',
      ]),
      SportSection(title: 'Основы', items: [
        'Система поясов показывает прогресс.',
        'Разминка и правильная техника предотвращают травмы.',
        'Контролируемая и уважительная работа обязательна.',
      ]),
    ],
  ),
  'taekwondo': SportContent(
    name: 'Тхэквондо',
    tagline: 'Техника ударов ногами, гибкость и дисциплина',
    sections: [
      SportSection(title: 'Описание', items: [
        'Тхэквондо — боевое искусство корейского происхождения, в котором '
            'особенно выделяется техника ударов ногами.',
        'Оно распространено и как спорт, и как самооборона, и является '
            'олимпийской дисциплиной.',
      ]),
      SportSection(title: 'Польза', items: [
        'Повышает гибкость и силу ног.',
        'Развивает равновесие, ловкость и реакцию.',
        'Прививает дисциплину и уверенность в себе.',
      ]),
      SportSection(title: 'Основы', items: [
        'Уровень растёт по системе поясов.',
        'Разминка и растяжка очень важны.',
        'Контролируемая техника и уважение обязательны.',
      ]),
    ],
  ),
  'judo': SportContent(
    name: 'Дзюдо',
    tagline: 'Равновесие, захват и броски',
    sections: [
      SportSection(title: 'Описание', items: [
        'Дзюдо — боевое искусство японского происхождения, основанное на '
            'выведении соперника из равновесия и контроле над ним.',
        'Вместо ударов используются захваты, броски и техники в партере.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает равновесие, силу захвата и контроль тела.',
        'Учит безопасно падать с помощью техник страховки (укэми).',
        'Прививает дисциплину, уважение и уверенность в себе.',
      ]),
      SportSection(title: 'Основы', items: [
        'Занятия проходят на татами; безопасное падение — основа.',
        'Прогресс идёт по системе поясов.',
        'Уважение и контроль по отношению к сопернику обязательны.',
      ]),
    ],
  ),
  'atletizm': SportContent(
    name: 'Лёгкая атлетика',
    tagline: 'Основа бега, прыжков и метаний',
    sections: [
      SportSection(title: 'Описание', items: [
        'Лёгкая атлетика — вид спорта, известный как «королева спорта», '
            'включающий дисциплины бега, прыжков и метаний.',
        'В ней много видов: бег на короткие/длинные дистанции, прыжки в длину '
            'и толкание ядра.',
      ]),
      SportSection(title: 'Польза', items: [
        'Гармонично развивает выносливость, скорость и силу.',
        'Укрепляет все базовые двигательные навыки.',
        'Прививает умение ставить личные цели и дисциплину.',
      ]),
      SportSection(title: 'Основы', items: [
        'Разминка и техника бега предотвращают травмы.',
        'У каждого вида своя техника.',
        'Прогресс отслеживается по измеримым целям.',
      ]),
    ],
  ),
  'masa-tenisi': SportContent(
    name: 'Настольный теннис',
    tagline: 'Реакция, скорость и концентрация',
    sections: [
      SportSection(title: 'Описание', items: [
        'Настольный теннис — быстрый вид спорта, основанный на перекидывании '
            'маленького мяча ракеткой на столе.',
        'Играют один на один или парами; требует очень быстрой реакции.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает координацию «глаз-рука» и реакцию на высоком уровне.',
        'Укрепляет концентрацию и быстрое принятие решений.',
        'Спорт, в который можно играть в любом возрасте с низким риском '
            'травм.',
      ]),
      SportSection(title: 'Основы', items: [
        'Подача и техники ударов — основа.',
        'Мяч должен один раз коснуться стола.',
        'Важна быстрая работа ног.',
      ]),
    ],
  ),
  'satranc': SportContent(
    name: 'Шахматы',
    tagline: 'Стратегия, внимание и планирование',
    sections: [
      SportSection(title: 'Описание', items: [
        'Шахматы — интеллектуальный спорт, в котором два игрока ведут '
            'стратегическую борьбу фигурами на доске из 64 клеток.',
        'Цель — поставить мат королю соперника.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает аналитическое мышление и умение планировать.',
        'Повышает внимание, терпение и концентрацию.',
        'Укрепляет навык решения задач и предвидения.',
      ]),
      SportSection(title: 'Основы', items: [
        'У каждой фигуры свой ход.',
        'Партия состоит из дебюта, миттельшпиля и эндшпиля.',
        'Прививает терпение и планирование наперёд.',
      ]),
    ],
  ),
  'hentbol': SportContent(
    name: 'Гандбол',
    tagline: 'Скорость, передачи и командная игра',
    sections: [
      SportSection(title: 'Описание', items: [
        'Гандбол — вид спорта, в который играют две команды по семь человек, '
            'основанный на передачах мяча руками и забивании в ворота '
            'соперника.',
        'Он включает быстрые переходы между атакой и защитой.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает скорость, прыжок и силу броска.',
        'Укрепляет командную игру и быстрое принятие решений.',
        'Улучшает координацию всего тела.',
      ]),
      SportSection(title: 'Основы', items: [
        'Мяч играют руками; в зону вратаря заходить нельзя.',
        'С мячом в руках можно сделать не более трёх шагов.',
        'Важны передачи и выбор позиции.',
      ]),
    ],
  ),
  'badminton': SportContent(
    name: 'Бадминтон',
    tagline: 'Ловкость, реакция и тайминг',
    sections: [
      SportSection(title: 'Описание', items: [
        'Бадминтон — ракеточный вид спорта, основанный на отправке волана '
            'через сетку на сторону соперника ракеткой.',
        'Играют один на один или парами; включает быстрые смены направления.',
      ]),
      SportSection(title: 'Польза', items: [
        'Развивает ловкость, реакцию и выносливость.',
        'Улучшает координацию «глаз-рука».',
        'Гармонично задействует всё тело.',
      ]),
      SportSection(title: 'Основы', items: [
        'По волану бьют до того, как он коснётся пола.',
        'Подача и смеш — базовые техники.',
        'Быстрая работа ног имеет решающее значение.',
      ]),
    ],
  ),
};

// ============================ FRENCH ========================================
const Map<String, SportContent> _fr = {
  'futbol': SportContent(
    name: 'Football',
    tagline: 'Jeu d\'équipe, coordination et endurance',
    sections: [
      SportSection(title: 'Description', items: [
        'Le football est un sport d\'équipe fondé sur l\'habileté du pied, où '
            'deux équipes tentent de marquer en envoyant le ballon dans le but '
            'adverse.',
        'Chaque équipe compte 11 joueurs, gardien inclus, et un match comporte '
            'deux mi-temps.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Améliore la santé cardiovasculaire et l\'endurance.',
        'Apprend le travail d\'équipe, la communication et le partage.',
        'Développe l\'équilibre, la coordination et l\'agilité.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le ballon ne se joue pas à la main (sauf le gardien dans la surface '
            'de réparation).',
        'Le but est de marquer en mettant le ballon dans le but adverse.',
        'Le fair-play et le respect de l\'adversaire sont essentiels.',
      ]),
    ],
  ),
  'basketbol': SportContent(
    name: 'Basket-ball',
    tagline: 'Vitesse, saut et coordination œil-main',
    sections: [
      SportSection(title: 'Description', items: [
        'Le basket-ball est un sport joué par deux équipes de cinq, où l\'on '
            'tente de marquer en lançant le ballon dans le panier adverse.',
        'Le ballon avance en dribble ou par des passes.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Améliore la détente et les réflexes.',
        'Renforce la coordination œil-main.',
        'Renforce la prise de décision rapide et le jeu d\'équipe.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Pas de double dribble ni de marcher (fautes) pendant le dribble.',
        'Les paniers valent 1, 2 ou 3 points selon la distance de tir.',
        'L\'équilibre entre défense et attaque est important.',
      ]),
    ],
  ),
  'voleybol': SportContent(
    name: 'Volley-ball',
    tagline: 'Harmonie d\'équipe, timing et saut',
    sections: [
      SportSection(title: 'Description', items: [
        'Le volley-ball est un sport où deux équipes séparées par un filet '
            'tentent d\'envoyer le ballon dans le camp adverse sans le laisser '
            'tomber.',
        'Chaque équipe renvoie le ballon en trois touches au maximum.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Améliore les réflexes et le sens du timing.',
        'Renforce la communication et l\'harmonie au sein de l\'équipe.',
        'Fait travailler le haut du corps et les muscles des jambes.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le même joueur ne peut pas toucher le ballon deux fois de suite.',
        'La manchette, la passe et le smash sont les techniques de base.',
        'Les points se gagnent en faisant tomber le ballon dans le camp '
            'adverse.',
      ]),
    ],
  ),
  'yuzme': SportContent(
    name: 'Natation',
    tagline: 'Un sport sûr qui fait travailler tout le corps',
    sections: [
      SportSection(title: 'Description', items: [
        'La natation est un sport individuel fondé sur le déplacement dans '
            'l\'eau avec différentes techniques (crawl, brasse, dos, '
            'papillon).',
        'Elle est importante à la fois comme compétition et comme compétence '
            'de vie.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Fait travailler tous les muscles sans solliciter les articulations.',
        'Améliore la capacité pulmonaire et l\'endurance.',
        'Apporte la sécurité dans l\'eau et la confiance en soi.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Une bonne technique de respiration est la base de la natation.',
        'L\'échauffement et la surveillance sont indispensables pour la '
            'sécurité.',
        'Les différents styles font travailler différents groupes '
            'musculaires.',
      ]),
    ],
  ),
  'tenis': SportContent(
    name: 'Tennis',
    tagline: 'Concentration, agilité et habileté manuelle',
    sections: [
      SportSection(title: 'Description', items: [
        'Le tennis est un sport joué en simple ou en double, fondé sur '
            'l\'envoi de la balle par-dessus le filet dans le camp adverse '
            'avec une raquette.',
        'Le but est de faire tomber la balle là où l\'adversaire ne peut pas '
            'la renvoyer.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Améliore l\'agilité, l\'équilibre et la coordination œil-main.',
        'Renforce la concentration et la capacité à élaborer une stratégie.',
        'Fait travailler tout le corps de façon équilibrée.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'La balle peut être frappée après un rebond.',
        'Le service, le coup droit et le revers sont les coups de base.',
        'Le système de points progresse en 15-30-40.',
      ]),
    ],
  ),
  'jimnastik': SportContent(
    name: 'Gymnastique',
    tagline: 'Souplesse, équilibre et contrôle du corps',
    sections: [
      SportSection(title: 'Description', items: [
        'La gymnastique est un sport où des mouvements exigeant souplesse, '
            'équilibre et force sont exécutés avec maîtrise.',
        'Elle comporte différentes disciplines comme le sol, la poutre et le '
            'saut.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe la souplesse et le contrôle du corps à un haut niveau.',
        'Améliore l\'équilibre, la posture et la force musculaire.',
        'Apporte discipline et confiance en soi.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'L\'échauffement et les étirements sont essentiels pour éviter les '
            'blessures.',
        'Les mouvements s\'apprennent progressivement et sous surveillance.',
        'Une technique correcte est la base de la sécurité.',
      ]),
    ],
  ),
  'karate': SportContent(
    name: 'Karaté',
    tagline: 'Discipline, équilibre et self-défense',
    sections: [
      SportSection(title: 'Description', items: [
        'Le karaté est un art martial d\'Extrême-Orient fondé sur des '
            'techniques de mains et de pieds.',
        'Il comporte deux parties principales : le kata (séquences de '
            'mouvements) et le kumite (travail à deux).',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe la discipline, la maîtrise de soi et le respect.',
        'Renforce l\'équilibre, la coordination et les réflexes.',
        'Apporte confiance en soi et capacité de self-défense.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le système de ceintures montre la progression.',
        'L\'échauffement et une technique correcte préviennent les blessures.',
        'Un travail contrôlé et respectueux est essentiel.',
      ]),
    ],
  ),
  'taekwondo': SportContent(
    name: 'Taekwondo',
    tagline: 'Techniques de coups de pied, souplesse et discipline',
    sections: [
      SportSection(title: 'Description', items: [
        'Le taekwondo est un art martial d\'origine coréenne où les techniques '
            'de coups de pied se distinguent particulièrement.',
        'Il est répandu à la fois comme sport et comme self-défense, et est '
            'une discipline olympique.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Augmente la souplesse et la force des jambes.',
        'Développe l\'équilibre, l\'agilité et les réflexes.',
        'Apporte discipline et confiance en soi.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le niveau progresse avec le système de ceintures.',
        'L\'échauffement et les étirements sont très importants.',
        'Une technique contrôlée et le respect sont essentiels.',
      ]),
    ],
  ),
  'judo': SportContent(
    name: 'Judo',
    tagline: 'Équilibre, préhension et projections',
    sections: [
      SportSection(title: 'Description', items: [
        'Le judo est un art martial d\'origine japonaise fondé sur le '
            'déséquilibre et le contrôle de l\'adversaire.',
        'Au lieu de frappes, il utilise des saisies, des projections et des '
            'techniques au sol.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe l\'équilibre, la force de préhension et le contrôle du '
            'corps.',
        'Apprend à chuter en sécurité grâce aux techniques de chute (ukemi).',
        'Apporte discipline, respect et confiance en soi.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'On s\'entraîne sur un tatami ; la chute en sécurité est '
            'fondamentale.',
        'On progresse avec le système de ceintures.',
        'Le respect et le contrôle envers l\'adversaire sont essentiels.',
      ]),
    ],
  ),
  'atletizm': SportContent(
    name: 'Athlétisme',
    tagline: 'La base de la course, du saut et du lancer',
    sections: [
      SportSection(title: 'Description', items: [
        'L\'athlétisme est un sport connu comme la « mère des sports », qui '
            'regroupe les disciplines de course, de saut et de lancer.',
        'Il comporte de nombreuses épreuves comme les courses de '
            'courte/longue distance, le saut en longueur et le lancer du '
            'poids.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe l\'endurance, la vitesse et la force de façon équilibrée.',
        'Renforce toutes les habiletés motrices de base.',
        'Apporte la fixation d\'objectifs individuels et la discipline.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'L\'échauffement et la technique de course préviennent les blessures.',
        'Chaque épreuve a sa propre technique.',
        'La progression se suit avec des objectifs mesurables.',
      ]),
    ],
  ),
  'masa-tenisi': SportContent(
    name: 'Tennis de table',
    tagline: 'Réflexes, vitesse et concentration',
    sections: [
      SportSection(title: 'Description', items: [
        'Le tennis de table est un sport rapide fondé sur l\'échange d\'une '
            'petite balle avec une raquette sur une table.',
        'Il se joue en simple ou en double et demande des réactions très '
            'rapides.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe la coordination œil-main et les réflexes à un haut niveau.',
        'Renforce la concentration et la prise de décision rapide.',
        'Un sport praticable à tout âge avec un faible risque de blessure.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le service et les techniques de frappe sont fondamentaux.',
        'La balle doit rebondir une fois sur la table.',
        'Un jeu de jambes rapide est important.',
      ]),
    ],
  ),
  'satranc': SportContent(
    name: 'Échecs',
    tagline: 'Stratégie, attention et planification',
    sections: [
      SportSection(title: 'Description', items: [
        'Les échecs sont un sport de l\'esprit où deux joueurs mènent une '
            'bataille stratégique avec des pièces sur un plateau de 64 cases.',
        'Le but est de mater le roi de l\'adversaire.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe la pensée analytique et la planification.',
        'Améliore l\'attention, la patience et la concentration.',
        'Renforce la résolution de problèmes et l\'anticipation.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Chaque pièce a sa propre façon de se déplacer.',
        'La partie se compose de l\'ouverture, du milieu de jeu et de la '
            'finale.',
        'Ils apportent patience et planification anticipée.',
      ]),
    ],
  ),
  'hentbol': SportContent(
    name: 'Handball',
    tagline: 'Vitesse, passes et jeu d\'équipe',
    sections: [
      SportSection(title: 'Description', items: [
        'Le handball est un sport joué par deux équipes de sept, fondé sur les '
            'passes à la main et sur le fait de marquer dans le but adverse.',
        'Il comporte de rapides transitions entre attaque et défense.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe la vitesse, la détente et la force de tir.',
        'Renforce le jeu d\'équipe et la prise de décision rapide.',
        'Améliore la coordination de tout le corps.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le ballon se joue à la main ; on n\'entre pas dans la zone du '
            'gardien.',
        'Le ballon peut être porté trois pas au maximum.',
        'La passe et le placement sont importants.',
      ]),
    ],
  ),
  'badminton': SportContent(
    name: 'Badminton',
    tagline: 'Agilité, réflexes et timing',
    sections: [
      SportSection(title: 'Description', items: [
        'Le badminton est un sport de raquette fondé sur l\'envoi d\'un volant '
            'par-dessus le filet dans le camp adverse avec une raquette.',
        'Il se joue en simple ou en double et comporte de rapides changements '
            'de direction.',
      ]),
      SportSection(title: 'Bienfaits', items: [
        'Développe l\'agilité, les réflexes et l\'endurance.',
        'Renforce la coordination œil-main.',
        'Fait travailler tout le corps de façon équilibrée.',
      ]),
      SportSection(title: 'Notions de base', items: [
        'Le volant est frappé avant de toucher le sol.',
        'Le service et le smash sont les techniques de base.',
        'Un jeu de jambes rapide est déterminant.',
      ]),
    ],
  ),
};

// ============================ ARABIC ========================================
const Map<String, SportContent> _ar = {
  'futbol': SportContent(
    name: 'كرة القدم',
    tagline: 'لعب جماعي وتناسق وتحمّل',
    sections: [
      SportSection(title: 'الوصف', items: [
        'كرة القدم رياضة جماعية تعتمد على مهارة القدم، حيث يحاول فريقان تسجيل '
            'الأهداف بإرسال الكرة إلى مرمى الخصم.',
        'يتكوّن كل فريق من 11 لاعباً بمن فيهم حارس المرمى، وتتكوّن المباراة من '
            'شوطين.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يحسّن صحة القلب والأوعية الدموية والتحمّل.',
        'يعلّم العمل الجماعي والتواصل والمشاركة.',
        'يكسب التوازن والتناسق والرشاقة.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'لا تُلعب الكرة باليد (باستثناء الحارس داخل منطقة الجزاء).',
        'الهدف هو التسجيل بإدخال الكرة إلى مرمى الخصم.',
        'اللعب النظيف واحترام الخصم أساسيان.',
      ]),
    ],
  ),
  'basketbol': SportContent(
    name: 'كرة السلة',
    tagline: 'سرعة وقفز وتناسق بين اليد والعين',
    sections: [
      SportSection(title: 'الوصف', items: [
        'كرة السلة رياضة يلعبها فريقان من خمسة لاعبين، حيث يُحاول تسجيل النقاط '
            'برمي الكرة في سلة الخصم.',
        'تتقدّم الكرة بالتنطيط (المراوغة) أو بالتمرير.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يحسّن قوة القفز وردود الفعل.',
        'يزيد التناسق بين اليد والعين.',
        'يقوّي اتخاذ القرار السريع واللعب الجماعي.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'لا يُسمح بالتنطيط المزدوج أو المشي (أخطاء) أثناء المراوغة.',
        'تُحتسب الرميات 1 أو 2 أو 3 نقاط حسب مسافة التسديد.',
        'التوازن بين الدفاع والهجوم مهم.',
      ]),
    ],
  ),
  'voleybol': SportContent(
    name: 'الكرة الطائرة',
    tagline: 'انسجام الفريق والتوقيت والقفز',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الكرة الطائرة رياضة يحاول فيها فريقان تفصل بينهما شبكة إرسال الكرة إلى '
            'ملعب الخصم دون تركها تسقط.',
        'يمرّر كل فريق الكرة بثلاث لمسات كحدّ أقصى.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يحسّن ردود الفعل ومهارة التوقيت.',
        'يقوّي التواصل والانسجام داخل الفريق.',
        'يعمل على عضلات الجزء العلوي من الجسم والساقين.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'لا يمكن للاعب نفسه لمس الكرة مرتين متتاليتين.',
        'الاستقبال والتمرير والضرب الساحق هي التقنيات الأساسية.',
        'تُكتسب النقاط بإسقاط الكرة في ملعب الخصم.',
      ]),
    ],
  ),
  'yuzme': SportContent(
    name: 'السباحة',
    tagline: 'رياضة آمنة تعمل على الجسم كله',
    sections: [
      SportSection(title: 'الوصف', items: [
        'السباحة رياضة فردية تعتمد على التقدّم في الماء بتقنيات مختلفة (حرة، '
            'صدر، ظهر، فراشة).',
        'مهمة كرياضة تنافسية وكمهارة حياتية على حدّ سواء.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'تعمل على جميع عضلات الجسم دون إجهاد المفاصل.',
        'تحسّن سعة الرئة والتحمّل.',
        'تكسب الأمان في الماء والثقة بالنفس.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'تقنية التنفّس الصحيحة هي أساس السباحة.',
        'الإحماء والإشراف ضروريان للسلامة.',
        'تعمل الأنماط المختلفة على مجموعات عضلية مختلفة.',
      ]),
    ],
  ),
  'tenis': SportContent(
    name: 'التنس',
    tagline: 'تركيز ورشاقة ومهارة يدوية',
    sections: [
      SportSection(title: 'الوصف', items: [
        'التنس رياضة تُلعب فردياً أو زوجياً، وتعتمد على إرسال الكرة فوق الشبكة '
            'إلى ملعب الخصم بالمضرب.',
        'الهدف هو إسقاط الكرة حيث لا يستطيع الخصم إعادتها.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يحسّن الرشاقة والتوازن والتناسق بين اليد والعين.',
        'يزيد التركيز ومهارة وضع الاستراتيجيات.',
        'يعمل على الجسم كله بشكل متوازن.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'يمكن ضرب الكرة بعد ارتدادها مرة واحدة.',
        'الإرسال والضربة الأمامية والخلفية هي الضربات الأساسية.',
        'يتقدّم نظام النقاط بصيغة 15-30-40.',
      ]),
    ],
  ),
  'jimnastik': SportContent(
    name: 'الجمباز',
    tagline: 'مرونة وتوازن وتحكّم بالجسم',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الجمباز رياضة تُؤدَّى فيها بإتقان حركات تتطلّب المرونة والتوازن '
            'والقوة.',
        'له تخصّصات مختلفة مثل الحركات الأرضية وعارضة التوازن والقفز.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يطوّر المرونة والتحكّم بالجسم إلى مستوى عالٍ.',
        'يحسّن التوازن والقوام وقوة العضلات.',
        'يكسب الانضباط والثقة بالنفس.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'الإحماء والتمدّد أساسيان لمنع الإصابات.',
        'تُتعلَّم الحركات تدريجياً وتحت الإشراف.',
        'التقنية الصحيحة هي أساس السلامة.',
      ]),
    ],
  ),
  'karate': SportContent(
    name: 'الكاراتيه',
    tagline: 'انضباط وتوازن ودفاع عن النفس',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الكاراتيه فن قتالي من الشرق الأقصى يعتمد على تقنيات اليدين والقدمين.',
        'له جزءان رئيسيان: الكاتا (تسلسل الحركات) والكوميتيه (التدريب الزوجي).',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يطوّر الانضباط وضبط النفس والاحترام.',
        'يقوّي التوازن والتناسق وردود الفعل.',
        'يكسب الثقة بالنفس ومهارة الدفاع عن النفس.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'نظام الأحزمة يُظهر التقدّم.',
        'الإحماء والتقنية الصحيحة يمنعان الإصابات.',
        'التدريب المنضبط والمحترم أساسي.',
      ]),
    ],
  ),
  'taekwondo': SportContent(
    name: 'التايكوندو',
    tagline: 'تقنيات الركل والمرونة والانضباط',
    sections: [
      SportSection(title: 'الوصف', items: [
        'التايكوندو فن قتالي كوري الأصل تبرز فيه تقنيات الركل بشكل خاص.',
        'منتشر كرياضة ودفاع عن النفس، وهو تخصّص أولمبي.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يزيد مرونة الساقين وقوّتها.',
        'يطوّر التوازن والرشاقة وردود الفعل.',
        'يكسب الانضباط والثقة بالنفس.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'يتقدّم المستوى بنظام الأحزمة.',
        'الإحماء والتمدّد مهمّان جداً.',
        'التقنية المنضبطة والاحترام أساسيان.',
      ]),
    ],
  ),
  'judo': SportContent(
    name: 'الجودو',
    tagline: 'توازن وإمساك وإسقاط أرضي',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الجودو فن قتالي ياباني الأصل يعتمد على فقدان توازن الخصم والسيطرة '
            'عليه.',
        'بدلاً من الضربات، يستخدم الإمساك والرمي والتقنيات الأرضية.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يطوّر التوازن وقوة الإمساك والتحكّم بالجسم.',
        'يعلّم السقوط الآمن بتقنيات السقوط (أوكيمي).',
        'يكسب الانضباط والاحترام والثقة بالنفس.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'يُتدرَّب على البساط؛ والسقوط الآمن أساسي.',
        'يُتقدَّم بنظام الأحزمة.',
        'الاحترام والسيطرة تجاه الخصم أساسيان.',
      ]),
    ],
  ),
  'atletizm': SportContent(
    name: 'ألعاب القوى',
    tagline: 'أساس الجري والقفز والرمي',
    sections: [
      SportSection(title: 'الوصف', items: [
        'ألعاب القوى رياضة تُعرف بـ"أم الألعاب"، وتشمل تخصّصات الجري والقفز '
            'والرمي.',
        'لها فروع عديدة مثل سباقات المسافات القصيرة/الطويلة والوثب الطويل ودفع '
            'الجلة.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'تطوّر التحمّل والسرعة والقوة بشكل متوازن.',
        'تقوّي جميع المهارات الحركية الأساسية.',
        'تكسب وضع الأهداف الفردية والانضباط.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'الإحماء وتقنية الجري يمنعان الإصابات.',
        'لكل فرع تقنيته الخاصة.',
        'يُتابَع التقدّم بأهداف قابلة للقياس.',
      ]),
    ],
  ),
  'masa-tenisi': SportContent(
    name: 'تنس الطاولة',
    tagline: 'ردود فعل وسرعة وتركيز',
    sections: [
      SportSection(title: 'الوصف', items: [
        'تنس الطاولة رياضة سريعة تعتمد على تبادل ضرب كرة صغيرة بمضرب على طاولة.',
        'يُلعب فردياً أو زوجياً ويتطلّب ردود فعل سريعة جداً.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يطوّر التناسق بين اليد والعين وردود الفعل إلى مستوى عالٍ.',
        'يقوّي التركيز واتخاذ القرار السريع.',
        'رياضة يمكن ممارستها في أي عمر بمخاطر إصابة منخفضة.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'الإرسال وتقنيات الضرب أساسية.',
        'يجب أن ترتدّ الكرة مرة واحدة على الطاولة.',
        'حركة القدمين السريعة مهمة.',
      ]),
    ],
  ),
  'satranc': SportContent(
    name: 'الشطرنج',
    tagline: 'استراتيجية وانتباه وتخطيط',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الشطرنج رياضة ذهنية يخوض فيها لاعبان معركة استراتيجية بالقطع على رقعة '
            'من 64 مربعاً.',
        'الهدف هو كِش مَلِك الخصم.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'يطوّر التفكير التحليلي ومهارة التخطيط.',
        'يحسّن الانتباه والصبر والتركيز.',
        'يقوّي حلّ المشكلات والتنبّؤ.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'لكل قطعة طريقتها الخاصة في الحركة.',
        'تتكوّن اللعبة من الافتتاح ووسط اللعب والنهاية.',
        'يكسب الصبر والتخطيط المسبق.',
      ]),
    ],
  ),
  'hentbol': SportContent(
    name: 'كرة اليد',
    tagline: 'سرعة وتمرير ولعب جماعي',
    sections: [
      SportSection(title: 'الوصف', items: [
        'كرة اليد رياضة يلعبها فريقان من سبعة لاعبين، وتعتمد على تمرير الكرة '
            'باليد والتسجيل في مرمى الخصم.',
        'تتضمّن انتقالات سريعة بين الهجوم والدفاع.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'تطوّر السرعة والقفز وقوة الرمي.',
        'تقوّي اللعب الجماعي واتخاذ القرار السريع.',
        'تحسّن تناسق الجسم كله.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'تُلعب الكرة باليد؛ ولا يُدخَل إلى منطقة الحارس.',
        'يمكن حمل الكرة باليد لثلاث خطوات كحدّ أقصى.',
        'التمرير وأخذ الموضع مهمّان.',
      ]),
    ],
  ),
  'badminton': SportContent(
    name: 'الريشة الطائرة',
    tagline: 'رشاقة وردود فعل وتوقيت',
    sections: [
      SportSection(title: 'الوصف', items: [
        'الريشة الطائرة رياضة مضرب تعتمد على إرسال ريشة فوق الشبكة إلى ملعب '
            'الخصم بالمضرب.',
        'تُلعب فردياً أو زوجياً وتتضمّن تغييرات سريعة في الاتجاه.',
      ]),
      SportSection(title: 'الفوائد', items: [
        'تطوّر الرشاقة وردود الفعل والتحمّل.',
        'تزيد التناسق بين اليد والعين.',
        'تعمل على الجسم كله بشكل متوازن.',
      ]),
      SportSection(title: 'معلومات أساسية', items: [
        'تُضرب الريشة قبل أن تلمس الأرض.',
        'الإرسال والضربة الساحقة هما التقنيتان الأساسيتان.',
        'حركة القدمين السريعة حاسمة.',
      ]),
    ],
  ),
};
