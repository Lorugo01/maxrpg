# MaxRPG - Assistente Digital para D&D 5e

Um aplicativo completo desenvolvido em Flutter para auxiliar jogadores e mestres de RPG no sistema D&D 5e.

## 🎲 Funcionalidades Implementadas

### ✅ MVP (Mínimo Produto Viável)
- **Rolador de Dados Avançado**: Interface intuitiva com animações para rolar d4, d6, d8, d10, d12, d20 e d100
- **Ficha de Personagem Digital**: Sistema completo de gerenciamento de personagens
- **Persistência Local**: Dados salvos automaticamente usando Hive
- **Cálculos Automáticos**: Modificadores, bônus de proficiência, testes de resistência

### 🎯 Funcionalidades Principais

#### Rolador de Dados
- Dados básicos (d4, d6, d8, d10, d12, d20, d100)
- Rolagens múltiplas (ex: 4d6 para atributos)
- Rolagens com modificadores
- Rolagens rápidas pré-configuradas (ataque, dano, teste, iniciativa)
- Animações e feedback visual
- Cores diferenciadas para críticos e falhas

#### Gerenciamento de Personagens
- Criação e edição de personagens
- Fichas completas com todas as informações D&D 5e:
  - Informações básicas (nome, raça, classe, nível, tendência)
  - Atributos (Força, Destreza, Constituição, Inteligência, Sabedoria, Carisma)
  - Perícias com proficiências e especialização
  - Inventário com tipos de itens e peso
  - Pontos de vida, CA, velocidade
  - Experiência e progressão de nível
  - Idiomas e proficiências

#### Interface e UX
- Design moderno com Material 3
- Navegação por abas na ficha do personagem
- Cards informativos e estatísticas visuais
- Temas consistentes por classe de personagem
- Feedback visual para ações do usuário

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.29.2**: Framework principal
- **Dart**: Linguagem de programação
- **Riverpod**: Gerenciamento de estado
- **Hive**: Banco de dados local NoSQL
- **Material Design 3**: Sistema de design

## 📱 Plataformas Suportadas

- ✅ Windows
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.29.2 ou superior
- Dart 3.7.2 ou superior

### Instalação
1. Clone o repositório:
```bash
git clone <url-do-repositorio>
cd maxrpg
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Gere os arquivos do Hive:
```bash
dart run build_runner build
```

4. Execute o aplicativo:
```bash
flutter run
```

## 📋 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados
│   ├── character.dart        # Modelo do personagem
│   ├── skill.dart           # Modelo das perícias
│   └── item.dart            # Modelo dos itens
├── screens/                  # Telas da aplicação
│   ├── home_screen.dart      # Tela inicial
│   ├── character_list_screen.dart # Lista de personagens
│   └── character_sheet_screen.dart # Ficha do personagem
├── widgets/                  # Componentes reutilizáveis
│   └── dice_roller_widget.dart # Rolador de dados
├── services/                 # Serviços e lógica de negócio
│   └── character_service.dart # Serviço de persistência
└── providers/                # Gerenciamento de estado
    └── character_provider.dart # Provider dos personagens
```

## 🎮 Como Usar

### Primeiros Passos
1. **Crie um Personagem**: Use o botão "Criar Exemplo" para gerar o Aragorn
2. **Explore a Ficha**: Navegue pelas abas para ver todas as informações
3. **Role os Dados**: Use o rolador integrado na tela inicial
4. **Gerencie Múltiplos Personagens**: Crie e alterne entre diferentes fichas

### Funcionalidades por Tela

#### Tela Inicial
- Estatísticas rápidas dos personagens
- Rolador de dados completo
- Acesso rápido às funcionalidades principais

#### Lista de Personagens
- Visualização de todos os personagens
- Seleção de personagem ativo
- Opções de duplicar e excluir
- Indicadores visuais de status

#### Ficha do Personagem
- **Aba Básico**: Informações gerais, pontos de vida, experiência
- **Aba Atributos**: Valores e modificadores, testes de resistência
- **Aba Perícias**: Lista completa com proficiências
- **Aba Inventário**: Itens, peso total, capacidade de carga

## 🔮 Funcionalidades Futuras

### Próximas Implementações
- [ ] Editor completo de personagens
- [ ] Sistema de magias e feitiços
- [ ] Calculadora de combate
- [ ] Gerador de personagens aleatórios
- [ ] Biblioteca de regras SRD
- [ ] Sincronização em nuvem
- [ ] Modo mestre com gerenciador de campanhas
- [ ] Sistema de notas e diário de aventuras

### Melhorias Planejadas
- [ ] Rolagens integradas na ficha
- [ ] Edição de pontos de vida em tempo real
- [ ] Sistema de condições e efeitos
- [ ] Importação/exportação de personagens
- [ ] Temas personalizáveis
- [ ] Suporte a outros sistemas (Pathfinder, etc.)

## ⚖️ Conformidade Legal

Este aplicativo utiliza apenas conteúdo disponível no **SRD (System Reference Document)** do D&D 5e, respeitando a **OGL (Open Game License)** da Wizards of the Coast. Nenhum conteúdo proprietário foi utilizado.

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para:
- Reportar bugs
- Sugerir novas funcionalidades
- Enviar pull requests
- Melhorar a documentação

## 📄 Licença

Este projeto está licenciado sob a MIT License - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👥 Créditos

Desenvolvido com ❤️ usando Flutter, seguindo as melhores práticas de desenvolvimento mobile e respeitando as diretrizes da comunidade D&D.

---

**Boas aventuras e ótimas rolagens! 🎲**