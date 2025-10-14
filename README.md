# MaxRPG - Assistente Digital para D&D 5e

Um aplicativo completo desenvolvido em Flutter para auxiliar jogadores e mestres de RPG no sistema D&D 5e, com arquitetura robusta e funcionalidades avançadas.

## 🎯 Visão Geral

O MaxRPG é um assistente digital completo que oferece:
- **Gerenciamento completo de personagens** com cálculos automáticos
- **Rolador de dados avançado** com animações e feedback visual
- **Sistema de autenticação** com sincronização em nuvem
- **Interface administrativa** para gerenciamento de dados D&D
- **Arquitetura escalável** seguindo as melhores práticas

## 🎲 Funcionalidades Implementadas

### ✅ Sistema de Personagens Completo
- **Criação e edição** de fichas de personagem passo a passo
- **Cálculos automáticos** de modificadores, CA, pontos de vida
- **Sistema de perícias** com proficiências e especialização
- **Inventário completo** com peso, valor e equipamentos
- **Sistema de magias** com slots, truques e magias conhecidas
- **Subclasses e características** de classe por nível
- **Progressão de nível** com escolhas e melhorias
- **Sistema de moedas** e testes de morte

### ✅ Rolador de Dados Avançado
- **Dados básicos**: d4, d6, d8, d10, d12, d20, d100
- **Rolagens múltiplas** (ex: 4d6 para atributos)
- **Modificadores** personalizáveis
- **Rolagens rápidas** pré-configuradas (ataque, dano, teste, iniciativa)
- **Animações** e feedback visual
- **Cores diferenciadas** para críticos e falhas

### ✅ Sistema de Autenticação e Usuários
- **Login/Registro** com Supabase Auth
- **Perfis de usuário** com tipos (simple/admin)
- **Sincronização em nuvem** dos personagens
- **Sistema de permissões** para administradores
- **Gerenciamento de sessão** automático

### ✅ Gerenciamento de Dados D&D
- **Classes completas** com progressão, subclasses e características
- **Raças** com bônus de atributos e características raciais
- **Antecedentes** (Backgrounds) com perícias e equipamentos
- **Magias** organizadas por nível e escola
- **Equipamentos** com propriedades e estatísticas
- **Talentos** (Feats) com pré-requisitos
- **Interface administrativa** para gerenciamento

### ✅ Interface e UX
- **Material Design 3** com tema personalizado
- **Navegação por abas** responsiva
- **Cards informativos** com gradientes
- **Feedback visual** para ações do usuário
- **Design responsivo** para desktop e mobile

## 🛠️ Stack Tecnológico

### Frontend
- **Flutter 3.29.2** - Framework principal
- **Dart 3.7.2** - Linguagem de programação
- **Riverpod** - Gerenciamento de estado reativo
- **Material Design 3** - Sistema de design

### Backend e Banco de Dados
- **Supabase** - Backend as a Service
- **PostgreSQL** - Banco de dados relacional
- **Row Level Security (RLS)** - Segurança de dados
- **Real-time subscriptions** - Sincronização em tempo real

### Utilitários
- **Window Manager** - Controle de janelas desktop
- **Flutter Dotenv** - Variáveis de ambiente
- **UUID** - Geração de identificadores únicos

## 📱 Plataformas Suportadas

- ✅ **Windows** (desktop otimizado)
- ✅ **Android** 
- ✅ **iOS**
- ✅ **Web**
- ✅ **macOS**
- ✅ **Linux**

## 🏗️ Arquitetura do Projeto

### Estrutura em Camadas

```
lib/
├── 📊 models/          # Camada de Dados (Domain Layer)
├── 🔧 services/        # Camada de Lógica de Negócio (Business Layer)  
├── 🎛️ providers/       # Camada de Estado (State Management)
├── 🖥️ screens/         # Camada de Apresentação (Presentation Layer)
├── 🧩 widgets/         # Camada de Componentes (Component Layer)
├── ⚙️ config/          # Camada de Configuração (Configuration Layer)
└── 🚀 main.dart        # Ponto de Entrada (Entry Point)
```

### Fluxo de Dados
```
UI (Screens) → Providers → Services → Models → Supabase
     ↑            ↑          ↑         ↑
   Widgets    State      Business   Domain
```

### Organização Detalhada

#### 📊 Models/ - Camada de Dados
- `character.dart` - Modelo principal do personagem
- `dnd_class.dart` - Classes D&D com progressão completa
- `skill.dart` - Perícias com proficiências
- `item.dart` - Itens do inventário
- `spell.dart` - Magias do sistema
- `race.dart` - Raças com características
- `background.dart` - Antecedentes
- `equipment.dart` - Equipamentos
- `feat.dart` - Talentos
- `level_up.dart` - Sistema de progressão
- `user_type.dart` - Tipos de usuário

#### 🔧 Services/ - Lógica de Negócio
- `supabase_service.dart` - Serviço base do Supabase
- `character_service_supabase.dart` - CRUD de personagens
- `auth_service.dart` - Autenticação
- `class_service.dart` - Gerenciamento de classes
- `race_service.dart` - Gerenciamento de raças
- `background_service.dart` - Gerenciamento de antecedentes
- `spell_service.dart` - Gerenciamento de magias
- `equipment_service.dart` - Gerenciamento de equipamentos
- `feat_service.dart` - Gerenciamento de talentos
- `ability_calculator.dart` - Cálculos avançados
- `data_migration_service.dart` - Migração de dados

#### 🎛️ Providers/ - Gerenciamento de Estado
- `auth_provider.dart` - Estado de autenticação
- `character_provider.dart` - Estado dos personagens

#### 🖥️ Screens/ - Interface do Usuário
```
screens/
├── 🔐 auth/                    # Autenticação
├── 🏠 main/                    # Telas principais
├── 👤 characters/              # Gerenciamento de personagens
├── 📚 rules/                   # Gerenciamento de regras D&D
│   ├── add/                    # Adicionar dados
│   ├── edit/                   # Editar dados
│   └── list/                   # Listar dados
├── 👑 admin/                   # Funcionalidades administrativas
├── 📊 data/                    # Gerenciamento de dados
└── 👤 profile/                 # Perfil do usuário
```

#### 🧩 Widgets/ - Componentes Reutilizáveis
- `dice_roller_widget.dart` - Rolador de dados completo

#### ⚙️ Config/ - Configurações
- `supabase_config.dart` - Configurações do Supabase

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.29.2 ou superior
- Dart 3.7.2 ou superior
- Conta no Supabase (para backend)

### Instalação

1. **Clone o repositório:**
```bash
git clone <url-do-repositorio>
cd maxrpg
```

2. **Instale as dependências:**
```bash
flutter pub get
```

3. **Configure as variáveis de ambiente:**
```bash
# Crie um arquivo .env na raiz do projeto
SUPABASE_URL=sua_url_do_supabase
SUPABASE_ANON_KEY=sua_chave_anonima
```

4. **Execute o aplicativo:**
```bash
flutter run
```

### Configuração do Supabase

1. Crie um projeto no [Supabase](https://supabase.com)
2. Execute os scripts SQL da pasta `database/` para criar as tabelas
3. Configure as políticas RLS (Row Level Security)
4. Adicione as credenciais no arquivo `.env`

## 🎮 Como Usar

### Primeiros Passos
1. **Registre-se** ou faça login na aplicação
2. **Crie seu perfil** de usuário
3. **Crie um personagem** usando o assistente passo a passo
4. **Explore a ficha** navegando pelas abas
5. **Role os dados** usando o rolador integrado

### Funcionalidades por Tela

#### Dashboard Principal
- Estatísticas rápidas dos personagens
- Rolador de dados completo
- Acesso rápido às funcionalidades principais
- Menu de usuário com opções administrativas

#### Gerenciamento de Personagens
- **Lista de personagens** com visualização e seleção
- **Ficha completa** com múltiplas abas (Básico, Atributos, Perícias, Inventário, Magias)
- **Criação passo a passo** com validações
- **Edição completa** de todas as características
- **Progressão de nível** com escolhas automáticas

#### Interface Administrativa (Admin)
- **Gerenciamento de dados** D&D (classes, raças, magias, etc.)
- **Migração de dados** dos assets para o banco
- **Gerenciamento de usuários** e permissões
- **Adição/edição** de conteúdo do sistema

## 🔮 Funcionalidades Futuras

### Próximas Implementações
- [ ] **Calculadora de combate** integrada
- [ ] **Gerador de personagens** aleatórios
- [ ] **Biblioteca de regras** SRD completa
- [ ] **Modo mestre** com gerenciador de campanhas
- [ ] **Sistema de notas** e diário de aventuras
- [ ] **Importação/exportação** de personagens
- [ ] **Sistema de condições** e efeitos
- [ ] **Temas personalizáveis** por classe

### Melhorias Planejadas
- [ ] **Rolagens integradas** na ficha do personagem
- [ ] **Edição de pontos de vida** em tempo real
- [ ] **Sistema de condições** e efeitos temporários
- [ ] **Suporte a outros sistemas** (Pathfinder, etc.)
- [ ] **Modo offline** com sincronização posterior
- [ ] **Notificações** de eventos importantes

## 🗄️ Estrutura do Banco de Dados

### Tabelas Principais
- `characters` - Fichas de personagem
- `classes` - Classes D&D com progressão completa
- `races` - Raças com características
- `backgrounds` - Antecedentes
- `spells` - Magias do sistema
- `equipment` - Equipamentos e itens
- `feats` - Talentos
- `skills` - Perícias dos personagens
- `items` - Inventário dos personagens
- `user_profiles` - Perfis de usuário

### Características do Banco
- **UUID** como chaves primárias
- **JSONB** para dados complexos
- **Triggers** para timestamps automáticos
- **Índices** para performance
- **Foreign Keys** para integridade referencial

## 🔐 Segurança e Conformidade

### Segurança
- **Autenticação** com Supabase Auth
- **Row Level Security (RLS)** no banco de dados
- **Variáveis de ambiente** para credenciais
- **Validação de dados** em todas as camadas

### Conformidade Legal
- **SRD (System Reference Document)** - Conteúdo aberto do D&D 5e
- **OGL (Open Game License)** - Licença de jogo aberto
- **Nenhum conteúdo proprietário** utilizado
- **Respeito às diretrizes** da Wizards of the Coast

## 🧪 Testes e Qualidade

### Estrutura de Testes
- **Testes unitários** para modelos e serviços
- **Testes de integração** para providers
- **Testes de widget** para componentes
- **Testes de navegação** para fluxos

### Qualidade de Código
- **Análise estática** com flutter_lints
- **Padrões de código** consistentes
- **Documentação** inline e README
- **Arquitetura** bem definida

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para:

### Como Contribuir
1. **Fork** o repositório
2. **Crie uma branch** para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. **Commit** suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. **Push** para a branch (`git push origin feature/nova-funcionalidade`)
5. **Abra um Pull Request**

### Áreas para Contribuição
- **Reportar bugs** e problemas
- **Sugerir novas funcionalidades**
- **Melhorar a documentação**
- **Otimizar performance**
- **Adicionar testes**
- **Traduções** para outros idiomas

## 📄 Licença

Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👥 Créditos

### Desenvolvimento
- **Desenvolvido com ❤️** usando Flutter
- **Arquitetura robusta** seguindo as melhores práticas
- **Design system** consistente e moderno
- **Performance otimizada** para todas as plataformas

### Agradecimentos
- **Comunidade D&D** por inspiração e feedback
- **Wizards of the Coast** pelo SRD e OGL
- **Comunidade Flutter** por ferramentas e suporte
- **Supabase** pela infraestrutura robusta

---

## 📊 Estatísticas do Projeto

- **+40 telas** organizadas por funcionalidade
- **+10 modelos** de dados interconectados
- **+10 serviços** de lógica de negócio
- **Arquitetura em 6 camadas** bem definidas
- **Suporte a 6 plataformas** diferentes
- **+50 tabelas** no banco de dados
- **Código 100% em português** para facilitar manutenção

---

**Boas aventuras e ótimas rolagens! 🎲**

*Desenvolvido com paixão pela comunidade RPG brasileira.*