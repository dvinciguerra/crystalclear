import { writable } from 'svelte/store';

const createUsername = () => {
	const { subscribe, set } = writable('Anonymous');

	return {
    set: (value) => set(value != '' ? value : 'Anonymous'),
		subscribe,
		reset: () => set('Anonymous'),
	};
}

export const username = createUsername();
