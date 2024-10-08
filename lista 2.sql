 -- 1 
 CREATE VIEW vw_alunos_disciplinas_cursos AS
SELECT 
    a.nome_aluno,
    d.nome_disciplina,
    c.nome_curso
FROM 
    Alunos a
JOIN 
    Matriculas m ON a.id_aluno = m.id_aluno
JOIN 
    Disciplinas d ON m.id_disciplina = d.id_disciplina
JOIN 
    Cursos c ON d.id_curso = c.id_curso;
SELECT * FROM vw_alunos_disciplinas_cursos;


-- 2
CREATE VIEW total_alunos_por_disciplina AS
SELECT 
    d.nome AS disciplina,
    COUNT(m.aluno_id) AS total_alunos
FROM 
    disciplinas d
LEFT JOIN 
    matriculas m ON d.id = m.disciplina_id
GROUP BY 
    d.nome;
SELECT * FROM total_alunos_por_disciplina;


-- 3
CREATE VIEW alunos_matriculas_status AS
SELECT 
    a.nome AS aluno,
    d.nome AS disciplina,
    m.status AS status_matricula
FROM 
    alunos a
JOIN 
    matriculas m ON a.id = m.aluno_id
JOIN 
    disciplinas d ON m.disciplina_id = d.id;
SELECT * FROM alunos_matriculas_status;

-- 4
CREATE VIEW professores_turmas AS
SELECT 
    p.nome AS professor,
    d.nome AS disciplina,
    t.horario AS horario_turma
FROM 
    professores p
JOIN 
    professor_disciplinas pd ON p.id = pd.professor_id
JOIN 
    disciplinas d ON pd.disciplina_id = d.id
JOIN 
    turmas t ON d.id = t.disciplina_id;
SELECT * FROM professores_turmas;

-- 5
CREATE VIEW alunos_maiores_20 AS
SELECT 
    nome,
    data_nascimento
FROM 
    alunos
WHERE 
    DATE_PART('year', AGE(data_nascimento)) > 20;
SELECT * FROM alunos_maiores_20;

-- 6
CREATE VIEW disciplinas_carga_horaria_por_curso AS
SELECT 
    c.nome AS curso_nome,
    COUNT(d.id) AS quantidade_disciplinas,
    SUM(d.carga_horaria) AS carga_horaria_total
FROM 
    cursos c
JOIN 
    curso_disciplinas cd ON c.id = cd.curso_id
JOIN 
    disciplinas d ON cd.disciplina_id = d.id
GROUP BY 
    c.id, c.nome;
SELECT * FROM disciplinas_carga_horaria_por_curso;


-- 7
CREATE VIEW professores_especialidades AS
SELECT 
    p.nome AS professor_nome,
    e.nome AS especialidade_nome
FROM 
    professores p
JOIN 
    especialidades e ON p.especialidade_id = e.id;
SELECT * FROM professores_especialidades;

-- 8
CREATE VIEW alunos_matriculados_multiplas_disciplinas AS
SELECT 
    a.nome AS aluno_nome,
    COUNT(m.disciplina_id) AS total_disciplinas
FROM 
    alunos a
JOIN 
    matriculas m ON a.id = m.aluno_id
GROUP BY 
    a.id
HAVING 
    COUNT(m.disciplina_id) > 1;
SELECT * FROM alunos_matriculados_mais_de_uma_disciplina;

-- 9
CREATE VIEW alunos_disciplinas_concluidas AS
SELECT 
    a.nome AS aluno_nome,
    COUNT(m.disciplina_id) AS quantidade_disciplinas_concluidas
FROM 
    alunos a
JOIN 
    matriculas m ON a.id = m.aluno_id
WHERE 
    m.status = 'Concluído'
GROUP BY 
    a.id;
SELECT * FROM alunos_disciplinas_concluidas;

-- 10
CREATE VIEW turmas_por_semestre AS
SELECT 
    t.id AS turma_id,
    t.nome AS turma_nome,
    t.horario AS turma_horario,
    t.semestre
FROM 
    turmas t
WHERE 
    t.semestre = '2024.1';
SELECT * FROM turmas_por_semestre;

-- 11
CREATE VIEW alunos_matriculas_trancadas AS
SELECT a.nome
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
WHERE m.status = 'Trancado';

-- 12
CREATE VIEW disciplinas_sem_alunos AS
SELECT d.nome
FROM disciplina d
LEFT JOIN matricula m ON d.id_disciplina = m.id_disciplina
WHERE m.id_disciplina IS NULL;

-- 13
CREATE VIEW alunos_status_matricula_quantidade AS
SELECT m.status, COUNT(a.id_aluno) AS total_alunos
FROM matricula m
JOIN aluno a ON m.id_aluno = a.id_aluno
GROUP BY m.status;

-- 14
CREATE VIEW professores_especialidade_quantidade AS
SELECT p.especialidade, COUNT(p.id_professor) AS total_professores
FROM professor p
GROUP BY p.especialidade;

-- 15
CREATE VIEW alunos_idades AS
SELECT a.nome, TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) AS idade
FROM aluno a;

-- 16
CREATE VIEW alunos_ultimas_matriculas AS
SELECT a.nome, MAX(m.data_matricula) AS ultima_matricula
FROM aluno a
JOIN matricula m ON a.id_aluno = m.id_aluno
GROUP BY a.nome;

-- 17
CREATE VIEW disciplinas_curso AS
SELECT d.nome
FROM disciplina d
JOIN curso c ON d.id_curso = c.id_curso
WHERE c.nome = 'Engenharia de Software';

-- 18
CREATE VIEW professores_sem_turmas AS
SELECT p.nome
FROM professor p
LEFT JOIN turma t ON p.id_professor = t.id_professor
WHERE t.id_professor IS NULL;

-- 19
CREATE VIEW alunos_cpf_email AS
SELECT a.nome, a.cpf, a.email
FROM aluno a;

-- 20
CREATE VIEW professores_disciplinas_quantidade AS
SELECT p.nome, COUNT(d.id_disciplina) AS total_disciplinas
FROM professor p
JOIN turma t ON p.id_professor = t.id_professor
JOIN disciplina d ON t.id_disciplina = d.id_disciplina
GROUP BY p.nome;
