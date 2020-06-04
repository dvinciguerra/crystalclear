import { writable } from 'svelte/store';

const createQuestions = () => {
	const { subscribe, set, update } = writable([]);

	return {
		set,
		subscribe,
    add: (question) => update(questions => [question, ...questions]),
		reset: () => set([])
	};
}

export const questions = createQuestions();
